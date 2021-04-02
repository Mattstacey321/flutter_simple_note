import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_app_bar.dart';
import '../../controllers/sign_up_controller.dart';

class SignUpMobile extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [Text("Sign Up")],
        onTapBack: () => Get.back(id: 1),
      ),
    );
  }
}
