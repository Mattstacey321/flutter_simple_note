import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/api.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/routes/app_pages.dart';
import 'package:simple_note/app/utils/dialogs_util.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();
  var userNameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  ApiClient _apiClient = ApiClient();
  AuthServices _authServices = AuthServices();

  Future onCancelSignUp() async {
    return DialogsUtil().cancelSignUp();
  }

  finishSignUp(int id) async {
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
    var result = await _apiClient.signUp(id: id, password: password, userName: userName);
    if (result != null) {
      _authServices.setLogin(
          User(id: result.id, name: result.name, email: result.email, avatarUrl: result.avatarUrl));
      Get.offNamedUntil(Routes.HOME, ModalRoute.withName('/home'));
      //save info
    } else {
      Get.back();
      Get.showSnackbar(GetBar(
        duration: 3.seconds,
        message: "Register fail. Check again",
      ));
    }
  }

  clearData() {
    userNameCtrl.clear();
    passwordCtrl.clear();
  }
}
