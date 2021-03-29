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
    final connection = _connection.baseUrl;
    print(connection);
    try {
      await GetConnect()
          .get(
            connection,
            decoder: (data) {},
          )
          .timeout(Duration(seconds: 10))
          .then(
        (Response value) {
          serverStatus(ServerStatus.online);
          Get.offAllNamed(_authSerivce.isLogin ? Routes.HOME : Routes.LOGIN);
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
