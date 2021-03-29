import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/api/folder_provider.dart';
import '../../../data/models/folder.dart';
import '../../../data/services/folder_services.dart';
import '../../../data/services/note_services.dart';
import '../../../global_widgets/loading_button.dart';
import '../../../utils/dialogs_util.dart';
import '../../../utils/toast_utils.dart';
import '../../home/controllers/home_controller.dart';

class SideBarController extends GetxController with StateMixin<List<Folder>> {
  static SideBarController get to => Get.find();
  final NoteServices noteServices;
  final FolderServices folderServices;
  final FolderProvider folderProvider;
  SideBarController({
    required this.noteServices,
    required this.folderServices,
    required this.folderProvider,
  });

  var folderNameCtrl = TextEditingController();
  var addFolderBtnCtl = LoadingButtonController();
  var editFolderBtnCtl = LoadingButtonController();
  var removeFolderBtnCtl = LoadingButtonController();

  var openSidebar = false.obs;
  var folders = <Folder>[].obs;
  var dropDownFolder = <Object>[].obs;

  void openSideBar() {
    openSidebar.toggle();
  }

  void createFolder() {
    DialogsUtil().addFolder(
      loadingCtrl: addFolderBtnCtl,
      onAdd: (String name, String description) async {
        final id = Uuid().v1();
        final folder =
            Folder(id: id, name: name, description: description, createdAt: DateTime.now());
        final result = await folderProvider.addFolder(folder);
        if (result.statusCode == 201) {
          //create success
          folderServices.add(folder);
          addFolderBtnCtl.success();
          Get.back();
          ToastUtils().addFolderSuccess();
        } else {
          //create fail
          addFolderBtnCtl.error();
          ToastUtils().addFolderFail();
        }
      },
    );
  }

  void openFolder(String folderId) {
    HomeController.to.setCurrentFolder(folderId);
  }

  void editFolder(String folderId) {
    final folder = folderServices.getById(folderId);
    DialogsUtil().editFolder(
      loadingCtrl: editFolderBtnCtl,
      name: folder.name,
      description: folder.description,
      onEdit: (String name, String description) async {
        final folder = folderServices.getById(folderId)
          ..name = name
          ..description = description;
        final result = await folderProvider.editFolder(folder);
        if (result.statusCode == 200) {
          folderServices.updateOne(folder);
          editFolderBtnCtl.success();
          ToastUtils().updateFolderSuccess();
          Get.back();
        } else {
          editFolderBtnCtl.error();
          ToastUtils().updateFolderFail();
        }
      },
    );
  }

  void removeFolder(String folderId) {
    final noteByFolder = noteServices.getNotes().where((e) => e.folderId == folderId);
    final countNoteByFolder = noteByFolder.length;
    final noteIds = noteByFolder.map<String>((e) => e.id!).toList();
    DialogsUtil().removeFolder(
      loadingCtrl: removeFolderBtnCtl,
      deleteNotify: countNoteByFolder >= 1 ? "All notes in folder will deleted." : null,
      onRemove: () async {
        final result = await folderProvider.removeFolder(folderId, noteIds: noteIds);
        if (result.statusCode == 200) {
          folderServices.remove(folderId);
          noteServices.removeMany(noteIds);
          removeFolderBtnCtl.success();
          ToastUtils().removeFolderSuccess();
          Get.back();
        } else {
          removeFolderBtnCtl.error();
          ToastUtils().removeFolderFail();
        }
      },
    );
  }

  int getTotalNote(String folderId) {
    return noteServices.getNotes().where((e) => e.folderId == folderId).length;
  }

  void initFolder() async {
    final localFolder = folderServices.getAll();
    //user remote data
    if (localFolder.isEmpty) {
      final result = await folderProvider.getFolder();
      if (result.statusCode == 200) {
        if (result.body!.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          folders.assignAll(result.body!);
          folderServices.updateMany(result.body!);
          change(result.body, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error());
      }
    } else {
      //use local data
      folders.assignAll(localFolder);
      //

      var folderNames = localFolder.map((e) => {"id": e.id, "name": e.name}).toList();
      dropDownFolder.assignAll([
        {"id": "", "name": "All note"},
        ...folderNames
      ]);

      change(localFolder, status: RxStatus.success());
    }
  }

  @override
  void onReady() {
    initFolder();
    // update on change
    folderServices.folderBox.watch().listen((event) {
      if (event.value != null) {
        folders.assignAll(folderServices.getAll());
      } else {
        folders.assignAll(folderServices.getAll());
      }
    });
    super.onReady();
  }
}
