import 'package:get/get.dart';
import 'package:simple_note/app/modules/login/controllers/sign_in_controller.dart';
import 'package:simple_note/app/modules/login/controllers/sign_up_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put(SignUpController());
    Get.put(SignInController());
  }
}
