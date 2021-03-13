import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/navigator_key_utils.dart';
import '../controllers/login_controller.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class LoginView extends GetResponsiveView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(NavigatorKeyUtils.loginNavigator),
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
