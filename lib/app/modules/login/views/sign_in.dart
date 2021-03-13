import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive_view/sign_in/sign_in_desktop.dart';
import '../responsive_view/sign_in/sign_in_mobile.dart';

class SignInResponseView extends GetResponsiveView {
  SignInResponseView() : super(alwaysUseBuilder: false);
  @override
  Widget phone() => SignInMobile();
  @override
  Widget desktop() => SignInDesktop();
}
