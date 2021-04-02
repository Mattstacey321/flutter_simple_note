import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/utils/dialogs_util.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../utils/toast_utils.dart';

class ViewNoteController extends GetxController with StateMixin<Note> {
  final NoteProvider noteProvider;
  final NoteServices noteServices;
  ViewNoteController({required this.noteProvider, required this.noteServices});
  var note = Rxn<Note>();
  var titleCtrl = TextEditingController();
  var contentCtrl = TextEditingController();
  var isAnyThingChange = false.obs;

  var initialTitleWord = "".obs;
  var currentTitleWord = "".obs;
  var initialContentWord = Rx<Document>(Document());
  var currentContentWord = "".obs;
  var selectedText = "".obs;
  var viewMode = true.obs;

  LoadingButtonController saveBtnCtrl = LoadingButtonController();
  QuillController quillCtrl = QuillController.basic();
  ScrollController quillScrollController = ScrollController();

  @override
  void onReady() {
    ever(note, (res) {
      isAnyThingChange(false);
    });
    contentSelection();
    super.onReady();
  }

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

  void contentSelection() {
    /*contentCtrl.addListener(() {
      // check content after delete equal original text
      if (contentCtrl.value.text == initialContentWord.value) {
        isAnyThingChange.value = false;
      }

      if (contentCtrl.selection.baseOffset == -1) {
        return;
      } else {
        selectedText.value = contentCtrl.selection.textInside(contentCtrl.text);
        /* Future.delayed(
            500.milliseconds,
            () => BotToast.showAttachedWidget(
                  target: Offset(start.toDouble(), end.toDouble()),
                  attachedBuilder: (cancelFunc) => Material(
                      child: Container(
                    height: 100,
                    width: 200,
                    child: Text("text selection"),
                  )),
                ));*/
      }
    });*/
  }

  void setValue(Note item) {
    note(item);
    final content = Document.fromJson(jsonDecode(item.content!));
    initialTitleWord.value = item.title!.trim();
    titleCtrl.text = item.title!;
    initialContentWord.value = content;

    quillCtrl = QuillController(document: content, selection: TextSelection.collapsed(offset: 0));
    quillCtrl.changes.listen((event) {
      // chcck on change
      for (var item in event.item2.toList()) {
        if (item.isRetain) {
          isAnyThingChange.value = true;
          return;
        } else {
          isAnyThingChange.value = false;
          return;
        }
      }
    });

    change(item, status: RxStatus.success());
  }

  void onTextChange() {
    currentContentWord.value = contentCtrl.text.trim();
    currentTitleWord.value = titleCtrl.text.trim();
    if (currentTitleWord.value == initialTitleWord.value) {
      isAnyThingChange.value = false;
      /*if (currentContentWord.value == initialContentWord.value) {
        isAnyThingChange.value = false;
      } else {
        isAnyThingChange.value = true;
      }*/
    } else
      isAnyThingChange.value = true;
  }

  void removeImage(int imageIndex) async {
    await DialogsUtil().confirmRemoveImage(
      onRemove: () {
        quillCtrl.replaceText(imageIndex, 1, "", null);
        Get.back();
      },
    );
  }

  void updateNote() async {
    final title = titleCtrl.text;
    final content = jsonEncode(quillCtrl.document.toDelta().toJson());

    final modifiedNote = note.value!.copyWith(title: title, content: content);
    try {
      final result = await noteProvider.updateNote(modifiedNote);
      if (result.statusCode == 200) {
        //noteServices.updateOne(modifiedNote);
        ToastUtils().updateNoteSuccess();
        saveBtnCtrl.success();
        isAnyThingChange.value = false;
      } else {
        ToastUtils().updateNoteFail();
        saveBtnCtrl.error();
      }
    } catch (e) {
      ToastUtils().updateNoteFail();
      saveBtnCtrl.error();
    }
  }

  void updateSuccess() {}

  void updateFail() {}

  void undoRemoveText() {
    //show cursor at the end of text
    contentCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: contentCtrl.text.length));
  }
}
