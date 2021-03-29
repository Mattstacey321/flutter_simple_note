import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/constraints/app_colors.dart';
import '../../../data/constraints/hive_box_name.dart';
import '../../../data/models/folder.dart';
import '../../../global_widgets/circle_icon.dart';
import '../../../global_widgets/custom_app_bar.dart';
import '../../../utils/loading_indicator.dart';
import '../../home/widgets/home_menu.dart';
import '../controllers/side_bar_controller.dart';
import '../widgets/collapse_item.dart';
import '../widgets/open_item.dart';

class SideBar extends GetView<SideBarController> {
  @override
  Widget build(BuildContext context) {
    var folderBox = Hive.box<Folder>(HiveBoxName.folder);
    return ObxValue<RxBool>(
      (res) {
        return res.value ? _buildOpen(folderBox) : _buildCollapse(folderBox);
      },
      controller.openSidebar,
    );
  }

  Widget _buildCollapse(Box<Folder> folderBox) {
    return Container(
      width: 60,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: AppColors.darkGrey.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          CircleIcon(
            onTap: () {
              controller.openSideBar();
            },
            icon: Icon(
              EvaIcons.menu,
              size: 20,
            ),
            tooltip: "",
          ),
          SizedBox(height: 20),
          CircleIcon(
            onTap: () {
              controller.createFolder();
            },
            icon: Icon(
              EvaIcons.folderAdd,
              size: 22,
            ),
            showToolTip: true,
            tooltip: "Add Folder",
          ),
          SizedBox(height: 20),
          Expanded(
            child: controller.obx(
              (state) => ValueListenableBuilder(
                valueListenable: folderBox.listenable(),
                builder: (context, Box<Folder> folderBox, child) {
                  final folders = folderBox.values.toList();
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: folders.length,
                    itemBuilder: (context, index) {
                      return CollapseItem(
                        folder: folders[index],
                        onTap: () {
                          controller.openFolder(folders[index].id);
                        },
                      );
                    },
                  );
                },
              ),
              onEmpty: CircleIcon(
                onTap: () {
                  controller.createFolder();
                },
                icon: Icon(
                  EvaIcons.folderAdd,
                  size: 22,
                ),
                tooltip: "Add Folder",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: HomeMenu(showOnlyProfile: true),
          )
        ],
      ),
    );
  }

  Widget _buildOpen(Box<Folder> folderBox) {
    return Expanded(
      child: Scaffold(
          backgroundColor: AppColors.darkGrey.withOpacity(0.5),
          appBar: CustomAppBar(
            childAlignment: MainAxisAlignment.start,
            childPadding: 20,
            childs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(child: HomeMenu()),
                  CircleIcon(
                    onTap: () {
                      controller.openSideBar();
                    },
                    icon: Icon(
                      EvaIcons.chevronLeft,
                      size: 22,
                    ),
                    tooltip: "Close Sidebar",
                  )
                ],
              ),
            ],
            color: AppColors.darkGrey.withOpacity(.2),
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            color: AppColors.darkGrey.withOpacity(.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Folders",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      CircleIcon(
                        onTap: () {},
                        icon: Icon(
                          Icons.sort,
                          size: 18,
                        ),
                        tooltip: "",
                      ),
                      CircleIcon(
                        onTap: () {
                          controller.createFolder();
                        },
                        icon: Icon(
                          EvaIcons.plus,
                          size: 18,
                        ),
                        tooltip: "",
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: controller.obx(
                      (state) => ValueListenableBuilder(
                        valueListenable: folderBox.listenable(),
                        builder: (context, Box<Folder> folderBox, child) {
                          final folders = folderBox.values.toList();
                          return ListView.separated(
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                            separatorBuilder: (context, index) => SizedBox(height: 20),
                            itemCount: folders.length,
                            itemBuilder: (context, index) {
                              var folderId = folders[index].id;
                              return OpenItem(
                                folder: folders[index],
                                total: controller.getTotalNote(folderId),
                                onTap: () {
                                  controller.openFolder(folderId);
                                },
                                onEdit: () {
                                  controller.editFolder(folderId);
                                },
                                onRemove: () {
                                  controller.removeFolder(folderId);
                                },
                              );
                            },
                          );
                        },
                      ),
                      onLoading: LoadingIndicators().defaultLoading(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
