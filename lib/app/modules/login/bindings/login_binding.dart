import 'package:get/get.dart';
import 'package:simple_note/app/data/api/auth_provider.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/modules/login/controllers/sign_in_controller.dart';
import 'package:simple_note/app/modules/login/controllers/sign_up_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => AuthServices());
    Get.lazyPut<LoginController>(
      () => LoginController(authProvier: Get.find(),authServices: Get.find()),
    );
    Get.put(SignUpController());
    Get.put(SignInController());
  }
}
