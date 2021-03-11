import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/note_services.dart';
import 'package:simple_note/app/utils/navigator_key_utils.dart';
import 'package:uuid/uuid.dart';

class AddNoteController extends GetxController {
  final NoteServices noteServices;
  AddNoteController({this.noteServices});
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  
  void addNote() {
    final id = Uuid().v1();
    final title = titleCtrl.text;
    final content = contentCtrl.text;
    final note = Note(id: id, title: title, content: content, createdAt: DateTime.now());
    try {
      noteServices.add(note);
      Get.showSnackbar(
        GetBar(
          message: "Create success",
          duration: 2.seconds,
        ),
      );
      Get.back(id: NavigatorKeyUtils.leftSideNavigator);
    } catch (e) {}
  }
}
