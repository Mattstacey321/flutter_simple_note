import 'package:get/get.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/services/auth_services.dart';
import '../controllers/login_controller.dart';
import '../controllers/sign_in_controller.dart';
import '../controllers/sign_up_controller.dart';

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
