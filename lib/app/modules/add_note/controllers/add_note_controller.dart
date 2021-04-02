import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/widgets/controller.dart';
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
  AddNoteController(
      {required this.noteServices, required this.noteProvider, required this.folderServices});
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  LoadingButtonController createBtnCtrl = LoadingButtonController();
  var canCreated = false.obs;
  var rxFolderId = RxString("");
  var quillController = QuillController.basic();
  ScrollController scrollController = ScrollController();

  void onTextChange() {}

  void addNote() async {
    final id = Uuid().v1();
    final title = titleCtrl.text;
    final folderId = rxFolderId.value;
    var note = Note(
      id: id,
      title: title,
      folderId: folderId,
      content: null,
      createdAt: DateTime.now(),
    );
    if (folderId != "") {
      try {
        final result = await noteProvider.addNote(note, quillController.document);
        if (result.statusCode == 200) {
          final body = result.body;
          note..content = body!.content;
          noteServices.add(note);
          createBtnCtrl.success();
          ToastUtils().addNoteSuccess();
          onClosePage();
        } else {
          createBtnCtrl.error();
          ToastUtils().addNoteFail();
        }
      } catch (e) {
        print(e);
        createBtnCtrl.error();
        ToastUtils().addNoteFail();
      }
    } else {
      createBtnCtrl.error();
      ToastUtils().addNoteFail(message: "Must select folder");
    }
  }

  void onClosePage() {
    titleCtrl.clear();
    quillController = QuillController.basic();
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
    scrollController = ScrollController();
    var names = folderServices.getAll().map((e) => {"id": e.id, "name": e.name}).toList();
    folderNames.assignAll([
      {"id": "", "name": "Select folder"},
      ...names
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    print("On close");
    super.onClose();
  }
}
