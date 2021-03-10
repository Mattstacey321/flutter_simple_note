import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/modules/login/views/sign_in.dart';
import 'package:simple_note/app/modules/login/views/sign_up.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetResponsiveView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: "/sign-in",
        onGenerateRoute: (settings) {
          if (settings.name == "/sign-in") {
            return GetPageRoute(
              routeName: "sign-in",
              page: () => SignInResponseView(),
            );
          } else {
            return GetPageRoute(
              routeName: "sign-up",
              page: () => SignUpResponseView(user: settings.arguments),
            );
          }
        },
      ),
    );
  }
}
