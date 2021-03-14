import 'dart:async';

import 'package:get/get.dart';
import 'package:simple_note/app/data/config/connection.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/routes/app_pages.dart';

enum ServerStatus { offline, online, checking }

class SplashScreenController extends GetxController {
  Connection _connection = Connection();
  AuthServices _authSerivce = AuthServices();
  var serverStatus = ServerStatus.checking.obs;

  void checkServer() async {
    try {
      await GetConnect().get(_connection.remoteUrl).timeout(Duration(seconds: 15)).then(
        (Response value) {
          Get.offAllNamed(_authSerivce.isLogin ? Routes.HOME : Routes.LOGIN);
          return serverStatus(ServerStatus.online);
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

  @override
  void onInit() {
    checkServer();
    super.onInit();
  }
}
