import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/folder.dart';
import '../../side_bar/controllers/side_bar_controller.dart';
import '../controllers/home_controller.dart';

class _DropDownController extends GetxController {
  var index = 0.obs;
  var list = [].obs;

  void setIndex(dynamic value) {
    index.value = list.indexOf(value);
    HomeController.to.setCurrentFolder(value["id"]);
  }

  void initData() {
    var folderNames =
        SideBarController.to.folders.map((e) => {"id": e.id, "name": e.name}).toList();
    list.assignAll([
      {"id": null, "name": "All note"},
      ...folderNames
    ]);
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    ever(HomeController.to.currentFolderId, (res) {
      index.value = list.indexWhere((e) => e["id"] == res);
    });

    ever(SideBarController.to.folders, (List<Folder> res) {
      var folderNames = res.map((e) => {"id": e.id, "name": e.name}).toList();
      list.assignAll([
        {"id": null, "name": "All note"},
        ...folderNames
      ]);
    });

    super.onReady();
  }
}

class FolderNameDropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<_DropDownController>(
      init: _DropDownController(),
      autoRemove: false,
      builder: (controller) {
        int selectedIndex = controller.index.value;
        return DropdownButtonHideUnderline(
          child: DropdownButton(
            onTap: () {},
            style: TextStyle(fontWeight: FontWeight.bold),
            items: controller.list
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Icon(EvaIcons.folder),
                          SizedBox(width: 10),
                          Text(e["name"]),
                        ],
                      ),
                    ))
                .toList(),
            value: controller.list[selectedIndex],
            onChanged: (value) {
              controller.setIndex(value);
            },
          ),
        );
      },
    );
  }
}
