import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/note_provider.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/note_services.dart';

class HomeController extends GetxController with StateMixin<List<Note>> {
  final NoteProvider noteProvider;
  final NoteServices noteServices;
  HomeController({this.noteProvider, this.noteServices});

  var currentOffsetDy = Rx<Offset>();
  var viewItemSpace = 1.obs;
  var viewNoteSpace = 1.obs;
  var notes = <Note>[].obs;

  @override
  void onReady() {
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
}
