import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../utils/dialogs_util.dart';
import '../../../utils/toast_utils.dart';

class HomeController extends GetxController with StateMixin<List<Note>> {
  final NoteProvider noteProvider;
  final NoteServices noteServices;
  HomeController({this.noteProvider, this.noteServices});

  var currentOffsetDy = Rx<Offset>();
  var viewItemSpace = 1.obs;
  var viewNoteSpace = 1.obs;
  var notes = <Note>[].obs;
  LoadingButtonController deleteBtnCtrl = LoadingButtonController();

  @override
  void onReady() {
    noteServices.noteBox.watch().listen((event) {
      if (event.value != null) {
        notes.assignAll(noteServices.getNotes());
      }else{
        notes.assignAll(noteServices.getNotes());
      }
    });

    ever(notes, (List<Note> res) {
      if (res.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(res, status: RxStatus.success());
      }
    });

    initData();
    super.onReady();
  }

  void initData() async {
    //retrive from local then online db

    final localResult = noteServices.getNotes();

    if (localResult.isEmpty) {
      final remoteResult = await noteProvider.getNotes();
      final notesResult = remoteResult.body ?? [];
      if (notesResult.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        noteServices.updateMany(notesResult);
        notes.assignAll(notesResult);
      }
    } else {
      notes.assignAll(localResult);
    }
  }

  void removeNote(String noteId) async {
    DialogsUtil().removeNoteDialog(
        loadingCtrl: deleteBtnCtrl,
        onRemove: () async {
          final noteIds = [noteId];
          try {
            final result = await noteProvider.removeNote(noteIds);
            if (result.statusCode == 200) {
              noteServices.remove(noteId);
              deleteBtnCtrl.success();
              ToastUtils().removeNoteSuccess();
              Get.back();
            } else {
              deleteBtnCtrl.error();
              ToastUtils().removeNoteFail();
            }
          } catch (e) {
            deleteBtnCtrl.  error();
            ToastUtils().removeNoteFail();
          }
        });
  }
}
