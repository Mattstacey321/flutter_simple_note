import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/dialogs_util.dart';
import '../../../utils/toast_utils.dart';
import '../../view_note/controllers/view_note_controller.dart';

class HomeController extends GetxController with StateMixin<List<Note>> {
  static HomeController get to => Get.find();
  final NoteProvider noteProvider;
  final NoteServices noteServices;
  HomeController({this.noteProvider, this.noteServices});

  var currentOffsetDy = Rx<Offset>();
  var viewItemSpace = 1.obs;
  var viewNoteSpace = 1.obs;
  var notes = <Note>[].obs;
  var deleteBtnCtrl = LoadingButtonController();

  var searchCtrl = TextEditingController();

  var searchFocusNode = FocusNode();
  var searchFieldNode = FocusNode();
  var searchMode = false.obs;
  var noteSearch = <Note>[].obs;
  var searchQuery = "".obs;
  var currentFolderId = RxString(null);

  @override
  void onReady() {
    noteServices.noteBox.watch().listen((event) {
      if (event.value != null) {
        notes.assignAll(noteServices.getNotes());
      } else {
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

    debounce(
      searchQuery,
      (String res) {
        noteSearch.clear();
        if (value.isEmpty) {
          searchMode.value = false;
        } else {
          searchMode.value = true;
          final sortResult = notes.where((e) => e.title.contains(res));
          noteSearch.addAll(sortResult);
        }
      },
      time: 500.milliseconds,
    );

    /*Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
    });*/

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
          deleteBtnCtrl.error();
          ToastUtils().removeNoteFail();
        }
      },
    );
  }

  void searchNote(BuildContext context) {
    FocusScope.of(context).requestFocus(searchFieldNode);
    if (searchFieldNode.hasFocus) {
      searchMode.value = true;
    } else {
      searchMode.value = false;
    }
  }

  void onSearch(String value) {
    searchQuery.value = value;
  }

  // void openSideBar() {
  //   openSidebar.toggle();
  // }

  void viewNote(BuildContext context, Note note) {
    final controller = Get.find<ViewNoteController>();
    if (context.isPhone) {
      controller.setValue(note);
      Get.toNamed(Routes.VIEW_NOTE);
    } else {
      final controller = Get.find<ViewNoteController>();
      controller.setValue(note);
    }
  }

  void setCurrentFolder(String folderId) {
    currentFolderId.value = folderId;
  }
}
