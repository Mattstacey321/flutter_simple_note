import 'package:flutter/cupertino.dart';
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
  AuthProvider authProvider = AuthProvider();
  AuthServices _authServices = AuthServices();

  Future onCancelSignUp() async {
    return DialogsUtil().cancelSignUp();
  }

  void finishSignUp(int id) async {
    final userName = userNameCtrl.text;
    final password = passwordCtrl.text;
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
    final result = await authProvider.signUp(id: id, password: password, userName: userName);
    final authReponse = result.body;
    if (authReponse.status == 201) {
      final user = authReponse.user;
      _authServices.setLogin(
          User(id: user.id, name: user.name, email: user.email, avatarUrl: user.avatarUrl));
      Get.offNamedUntil(Routes.HOME, ModalRoute.withName('/home'));
    }
    else {
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
