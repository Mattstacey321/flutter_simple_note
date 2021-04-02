import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/models/user.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/dialogs_util.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();
  var userNameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  AuthProvider authProvider;
  AuthServices authServices;
  SignUpController({required this.authProvider, required this.authServices});

  Future onCancelSignUp() async {
    return DialogsUtil().cancelSignUp(
      onExit: () {
        Get.back(id: 1);
        Get.back();
        clearData();
      },
    );
  }

  void finishSignUp(int id) async {
    final userName = userNameCtrl.text;
    final password = passwordCtrl.text;
    DialogsUtil().loadingDialog();
    final result = await authProvider.signUp(id: id, password: password, userName: userName);
    final authReponse = result.body;
    if (authReponse!.status == 201) {
      final user = authReponse.user;
      authServices.setLogin(
          User(id: user.id, name: user.name, email: user.email, avatarUrl: user.avatarUrl));
      Get.offNamedUntil(Routes.HOME, ModalRoute.withName('/home'));
    } else {
      Get.back();
      Get.showSnackbar(GetBar(
        duration: 3.seconds,
        message: "Register fail. Check again",
      ));
    }
  }

  void clearData() {
    userNameCtrl.clear();
    passwordCtrl.clear();
  }
}
