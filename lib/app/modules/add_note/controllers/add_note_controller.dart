import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/note_provider.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/note_services.dart';
import 'package:simple_note/app/global_widgets/loading_button.dart';
import 'package:simple_note/app/utils/navigator_key_utils.dart';
import 'package:simple_note/app/utils/toast_utils.dart';
import 'package:uuid/uuid.dart';

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
        createBtnCtrl.success();
        ToastUtils().addNoteSuccess();
        onClosePage();
      } else {
        createBtnCtrl.error();
        //Future.delayed(Duration(seconds: 1), () => createBtnCtrl.reset());
        ToastUtils().addNoteFail();
      }
    } catch (e) {
      print(e);
      createBtnCtrl.error();
      ToastUtils().addNoteFail();
    }
  }

  void onClosePage() {
    titleCtrl.clear();
    contentCtrl.clear();
    createBtnCtrl.reset();
    Get.back(id: NavigatorKeyUtils.leftSideNavigator);
  }

  @override
  void onClose() {
    print("On close");
    super.onClose();
  }
}
