import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/api.dart';
import 'package:simple_note/app/data/models/auth_reponse.dart';
import 'package:simple_note/app/utils/dialogs_util.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  ApiClient _client = ApiClient();
  var userNameCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  final clientId = "c21fbd733f56a193d249";

  Future<AuthResponse> authWithGithub(String code) async {
    final authResponse = await _client.authWithGithub(code);
    return authResponse;
    /*if (authResponse.isCreated = false)
      // account bind with github account created
      // save info, go to home page
     // _authServices.setLogin(Authentication(userName: ""));
      return true;
    else
      return true;*/
  }

  void requestGithubCode() async {
    String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        "$clientId" +
        "&scope=public_repo%20read:user%20user:email";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    Timer(2.seconds, () {
      DialogsUtil().enterCode();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
