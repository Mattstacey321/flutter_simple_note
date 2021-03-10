import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/api/api.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/note_services.dart';

class HomeController extends GetxController with StateMixin<List<Note>> {
  NoteServices _noteServices = NoteServices();
  ApiClient _apiClient = ApiClient();
  var currentOffsetDy = Rx<Offset>();
  var viewItemSpace = 1.obs;
  var viewNoteSpace = 1.obs;
  var notes = <Note>[].obs;

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  void initData() async {
    //retrive from local then online db

    final localResult = _noteServices.getNotes();
    if (localResult.isEmpty) {

      final remoteResult = await _apiClient.getNotes();
      localResult.assignAll(remoteResult);

      if (localResult.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        notes.assignAll(localResult);
        change(localResult, status: RxStatus.success());
      }
    }else{
      final remoteResult = await _apiClient.getNotes();
      localResult.assignAll(remoteResult);
      if (localResult.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        notes.assignAll(localResult);
        change(localResult, status: RxStatus.success());
      }
    }
  }
}
