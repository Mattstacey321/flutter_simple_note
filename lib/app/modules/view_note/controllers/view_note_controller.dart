import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/note_services.dart';

class ViewNoteController extends GetxController with StateMixin<Note> {
  final NoteProvider noteProvider;
  final NoteServices noteServices;
  ViewNoteController({this.noteProvider, this.noteServices});
  var note = Rx<Note>();
  var titleCtrl = TextEditingController();
  var contentCtrl = TextEditingController();
  var isAnyThingChange = false.obs;

  var initialTitleWord = "".obs;
  var currentTitleWord = "".obs;
  var initialContentWord = "".obs;
  var currentContentWord = "".obs;

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.onClose();
  }

  void setValue(Note item) {
    note.value = item;
    initialTitleWord.value = item.title.trim();
    initialContentWord.value = item.content.trim();
    //initialCountWord.value = totalWord;

    titleCtrl.text = item.title;
    contentCtrl.text = item.content;
    change(item, status: RxStatus.success());
  }

  /*void listenNoteChange() {

    note.listen((res) {
      titleCtrl.text = res.title;
      contentCtrl.text = res.content;
      change(res, status: RxStatus.success());
    });
  }*/

  void onTextChange() {
    currentContentWord.value = contentCtrl.text.trim();
    currentTitleWord.value = titleCtrl.text.trim();
    if (currentTitleWord.value == initialTitleWord.value) {
      isAnyThingChange.value = false;
      if (currentContentWord.value == initialContentWord.value) {
        isAnyThingChange.value = false;
      } else {
        isAnyThingChange.value = true;
      }
    } else
      isAnyThingChange.value = true;
  }

  void updateNote() async {
    final title = titleCtrl.text;
    final content = contentCtrl.text;
    final updatedNote = note.value.copyWith(title: title, content: content);
    try {
      noteServices.updateOne(updatedNote);
      await noteProvider.updateNote(updatedNote);
      Get.showSnackbar(GetBar(
        message: "Update success",
        duration: 2.seconds,
      ));
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: "Can not update",
        duration: 2.seconds,
      ));
    }
  }
}
