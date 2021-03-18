import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/api/note_provider.dart';
import '../../../data/models/note.dart';
import '../../../data/services/folder_services.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../utils/navigator_key_utils.dart';
import '../../../utils/toast_utils.dart';

class AddNoteController extends GetxController {
  final NoteServices noteServices;
  final NoteProvider noteProvider;
  final FolderServices folderServices;
  AddNoteController({this.noteServices, this.noteProvider, this.folderServices});
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  LoadingButtonController createBtnCtrl = LoadingButtonController();
  var canCreated = false.obs;
  var rxFolderId = RxString(null);

  void onTextChange() {}

  void addNote() async {
    final id = Uuid().v1();
    final title = titleCtrl.text;
    final content = contentCtrl.text;
    final folderId = rxFolderId.value;
    final note =
        Note(id: id, title: title, folderId: folderId, content: content, createdAt: DateTime.now());

    try {
      final result = await noteProvider.addNote(note);
      if (result.statusCode == 200) {
        noteServices.add(note);
        createBtnCtrl.success();
        ToastUtils().addNoteSuccess();
        onClosePage();
      } else {
        createBtnCtrl.error();
        ToastUtils().addNoteFail();
      }
    } catch (e) {
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

  void setFolderId(dynamic value) {
    selectedIndex.value = folderNames.indexOf(value);
    rxFolderId.value = value["id"];
  }

  var folderNames = [].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    var names = folderServices.getAll().map((e) => {"id": e.id, "name": e.name}).toList();
    folderNames.assignAll(names);
    super.onInit();
  }

  @override
  void onClose() {
    print("On close");
    super.onClose();
  }
}
