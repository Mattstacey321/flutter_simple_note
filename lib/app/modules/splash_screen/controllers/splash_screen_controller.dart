import 'dart:async';

import 'package:get/get.dart';

import '../../../data/config/connection.dart';
import '../../../data/services/auth_services.dart';
import '../../../data/services/setting_services.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/dialogs_util.dart';

enum ServerStatus { offline, online, checking }

class SplashScreenController extends GetxController {
  Connection _connection = Connection();
  AuthServices _authSerivce = AuthServices();
  SettingServices _settingServices = SettingServices();
  var serverStatus = ServerStatus.checking.obs;

  void checkServer() async {
    try {
      await GetConnect().get(_connection.baseUrl).timeout(Duration(seconds: 10)).then(
        (Response value) {
          Get.offAllNamed(_authSerivce.isLogin ? Routes.HOME : Routes.LOGIN);
          serverStatus(ServerStatus.online);
        },
      );
    } on TimeoutException catch (_) {
      serverStatus(ServerStatus.offline);
    }
  }

  void reCheck() {
    if (serverStatus.value == ServerStatus.offline) {
      serverStatus(ServerStatus.checking);
    }
  }

  void offlineMode() {
    DialogsUtil().confirmOfflineMode(onConfirm: () {
      _settingServices.setOfflineMode();
      Get.offAllNamed(Routes.HOME);
    });
  }

  @override
  void onInit() {
    checkServer();
    super.onInit();
  }
}
