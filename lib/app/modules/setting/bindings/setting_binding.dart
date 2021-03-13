import 'package:get/get.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/api/note_provider.dart';
import '../../../data/services/auth_services.dart';
import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthServices());
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => NoteProvider());
    Get.lazyPut<SettingController>(
      () => SettingController(
          authProvider: Get.find(), authServices: Get.find(), noteProvider: Get.find()),
    );
  }
}
