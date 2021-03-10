import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/note_services.dart';
import 'package:uuid/uuid.dart';

class AddNoteController extends GetxController {
  var _noteSerivce = NoteServices();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  void addNote() {
    final id = Uuid().v1();
    final title = titleCtrl.text;
    final content = contentCtrl.text;
    final note = Note(id: id, title: title, content: content, createdTime: DateTime.now());
    final result = _noteSerivce.add(note);
    if (result) {
      Get.showSnackbar(
        GetBar(
          message: "Create success",
          duration: 2.seconds,
        ),
      );
      Get.back(id: 1);
    }
  }
}
