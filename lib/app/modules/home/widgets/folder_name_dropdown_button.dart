import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/folder.dart';
import '../../side_bar/controllers/side_bar_controller.dart';
import '../controllers/home_controller.dart';

class _DropDownController extends GetxController {
  static _DropDownController get to => Get.find();
  var list = [].obs;

  void setIndex(dynamic value) {
    HomeController.to.setCurrentFolder(value["id"]);
  }

  void initData() {
    var folderNames =
        SideBarController.to.folders.map((e) => {"id": e.id, "name": e.name}).toList();
    list.assignAll([
      {"id": "", "name": "All note"},
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
    //TODO:  change view of current folder when click on folder icon
   /* ever(HomeController.to.currentFolderId, (res) {
      index.value = list.indexWhere((e) => e["id"] == res);
    });*/

    ever(SideBarController.to.folders, (List<Folder> res) {
      var folderNames = res.map((e) => {"id": e.id, "name": e.name}).toList();
      list.assignAll([
        {"id": "", "name": "All note"},
        ...folderNames
      ]);
    });

    super.onReady();
  }
}

class FolderNameDropDownButton extends StatefulWidget {
  final List<dynamic> dataSource;
  final Function(Object?, int, _DropDownController) onSelected;
  FolderNameDropDownButton({required this.onSelected, required this.dataSource});

  @override
  _FolderNameDropDownButtonState createState() => _FolderNameDropDownButtonState();
}

class _FolderNameDropDownButtonState extends State<FolderNameDropDownButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_DropDownController>(
      init: _DropDownController(),
      autoRemove: false,
      builder: (controller) {
        var _dataSource = widget.dataSource.isNotEmpty ? widget.dataSource : controller.list;
        return DropdownButtonHideUnderline(
          child: DropdownButton(
            onTap: () {},
            style: TextStyle(fontWeight: FontWeight.bold),
            items: _dataSource
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
            value: _dataSource[selectedIndex],
            onChanged: (value) {
              setState(() {
                selectedIndex = _dataSource.indexOf(value);
              });
              value != null
                  ? widget.onSelected(value, selectedIndex, _DropDownController())
                  : null;
            },
          ),
        );
      },
    );
  }
}
