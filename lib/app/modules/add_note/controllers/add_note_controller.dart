import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../utils/navigator_key_utils.dart';
import '../../../utils/toast_utils.dart';

class AddNoteController extends GetxController {
  final NoteServices noteServices;
  final NoteProvider noteProvider;
  AddNoteController({this.noteServices, this.noteProvider});
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  LoadingButtonController createBtnCtrl = LoadingButtonController();
  var canCreated = false.obs;

  void onTextChange() {}

  void addNote() async {
    final id = Uuid().v1();
    final title = titleCtrl.text;
    final content = contentCtrl.text;
    final note = Note(id: id, title: title, content: content, createdAt: DateTime.now());

    try {
      final result = await noteProvider.addNote(note);
      if (result.statusCode == 200) {
        noteServices.add(note);
        stateSuccess();
        onClosePage();
      } else {
        createBtnCtrl.error();
        ToastUtils().addNoteFail();
      }
    } catch (e) {
      stateFail();
      print(e);
    }
  }

  void onClosePage() {
    titleCtrl.clear();
    contentCtrl.clear();
    createBtnCtrl.reset();
    Get.back(id: NavigatorKeyUtils.leftSideNavigator);
  }

  void stateSuccess() {
    createBtnCtrl.success();
    ToastUtils().addNoteSuccess();
  }

  void stateFail() {
    createBtnCtrl.error();
    ToastUtils().addNoteFail();
  }

  @override
  void onClose() {
    print("On close");
    super.onClose();
  }
}
