import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/auth_provider.dart';
import 'package:simple_note/app/data/api/note_provider.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/routes/app_pages.dart';
import 'package:simple_note/app/utils/dialogs_util.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthProvider authProvider;
  final AuthServices authServices;
  final NoteProvider noteProvider;
  SettingController({this.authProvider, this.authServices, this.noteProvider});

  var rxUser = Rx<User>();
  var ratios = ["1:1", "1:2", "2:1"];

  User get user => rxUser.value;

  void logOut() {
    DialogsUtil().logOutDialog(onLogOut: () {
      try {
        authServices.removeInfo();
        Get.offNamedUntil(Routes.LOGIN, ModalRoute.withName(Routes.LOGIN));
      } catch (e) {
        BotToast.showText(
          text: "Cannot log out...",
          align: Alignment(0, 0.9),
        );
      }
    });
  }

  void backupData() async {
    BotToast.showText(
      text: "Prepare backup... Please wait",
      align: Alignment(0, 0.9),
    );
    final result = await noteProvider.saveToDb();
    if (result.statusCode == 200) {
      BotToast.showText(
        text: "Backup success",
        align: Alignment(0, 0.9),
      );
    } else {
      BotToast.showText(
        text: "Fail during backup",
        align: Alignment(0, 0.9),
      );
    }
  }

  @override
  void onReady() {
    rxUser.value = authServices.getUser;
    super.onReady();
  }
}
