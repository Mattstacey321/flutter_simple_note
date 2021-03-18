import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

import '../../../data/models/user.dart';
import '../controllers/sign_up_controller.dart';
import '../responsive_view/sign_up/sign_up_desktop.dart';
import '../responsive_view/sign_up/sign_up_mobile.dart';

class SignUpResponseView extends GetResponsiveView<SignUpController> {
  final User user;
  SignUpResponseView({this.user}) : super(alwaysUseBuilder: false);

  @override
  Widget phone() {
    return SignUpMobile();
  }

  @override
  Widget desktop() {
    final userInfo = user;
    return SignUpDesktop(userId: userInfo?.id);
  }
}
