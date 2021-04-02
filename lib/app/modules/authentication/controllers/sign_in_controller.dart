import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/models/auth_reponse.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/dialogs_util.dart';
import '../../../utils/navigator_key_utils.dart';

class SignInController extends GetxController {
  final AuthProvider authProvier;
  final AuthServices authServices;
  SignInController({required this.authProvier, required this.authServices});
  var userNameCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  final clientId = "c21fbd733f56a193d249";
  var isValidated = false.obs;

  void requestGithubCode() async {
    String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        "$clientId" +
        "&scope=public_repo%20read:user%20user:email";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    Timer(2.seconds, () {
      DialogsUtil().enterCode(
        onConfirm: (String code) async {
          DialogsUtil().loadingDialog();
          final authReponse = await authWithGithub(code);
          final user = authReponse.user;
          // created user
          if (authReponse.status == 201) {
            //auth succcss
            // offall to home
            Get.back(closeOverlays: true);
            Get.toNamed(Routes.SIGNUP,
                id: NavigatorKeyUtils.loginNavigator, arguments: authReponse.user);
          } else if (authReponse.status == 200) {
            Get.back(closeOverlays: true);
            AuthServices().setLogin(user);
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.back();
            Get.showSnackbar(GetBar(
              duration: 3.seconds,
              message: "Error during sign up",
            ));
          }
        },
      );
    });
  }

  Future<AuthResponse> authWithGithub(String code) async {
    final authResponse = await authProvier.authWithGithub(code);
    return authResponse.body;
  }

  void logIn() async {
    final userName = userNameCtrl.text;
    final password = pwdCtrl.text;
    DialogsUtil().loadingDialog();
    final result = await authProvier.logIn(userName, password);
    if (result.statusCode == 200) {
      final loginResult = result.body;
      authServices.setLogin(loginResult.user);
      Get.showSnackbar(GetBar(
        message: "Login success",
      ));
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.showSnackbar(GetBar(
        message: "Login fail.",
      ));
      Get.back();
    }
  }

  void validateUsername(String value) {
    isValidated(value.length > 5);
  }

  void validatePassword(String value) {
    isValidated(value.length >= 5);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
