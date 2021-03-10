import 'package:get/get.dart';
import 'package:simple_note/app/data/api/api.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/data/services/note_services.dart';
import 'package:simple_note/app/routes/app_pages.dart';
import 'package:simple_note/app/utils/dialogs_util.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  AuthServices _authServices = AuthServices();
  ApiClient _apiClient = ApiClient();
  NoteServices _noteServices = NoteServices();
  var user = Rx<User>();
  var ratios = ["1:1", "1:2", "2:1"];
  void logOut() {
    DialogsUtil().logOutDialog(onLogOut: () {
      bool removeSuccess = _authServices.removeInfo();
      if (removeSuccess) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.showSnackbar(GetBar(
          duration: 3.seconds,
          message: "Can not log out",
        ));
      }
    });
  }

  void backupData() async {
    final notes = _noteServices.getNotes();
    final result = await _apiClient.backupData(notes);
    if (result) {
      Get.showSnackbar(GetBar(
        duration: 3.seconds,
        message: "Backup success!",
      ));
    } else {
      Get.showSnackbar(GetBar(
        duration: 3.seconds,
        message: "Backup fail",
      ));
    }
  }

  @override
  void onReady() {
    user.value = _authServices.user;
    super.onReady();
  }
}
