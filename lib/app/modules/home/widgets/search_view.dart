import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../side_bar/controllers/side_bar_controller.dart';

import '../../../data/constraints/app_state.dart';
import '../../../routes/app_pages.dart';
import '../../view_note/controllers/view_note_controller.dart';
import '../controllers/home_controller.dart';
import 'note_item.dart';

class SearchView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isOpen = SideBarController.to.openSidebar.value;
        final searchResult = controller.noteSearch;
        int crossAxisCOunt = isOpen ? 1 : 2;
        return searchResult.isEmpty
            ? AppStates().searchEmpty()
            : GridView.count(
                crossAxisCount: crossAxisCOunt,
                childAspectRatio: context.isPhone ? Get.width / (Get.height / 2.5) : (isOpen ? 3 : 2.5),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: searchResult
                    .map(
                      (e) => NoteItem(
                        item: e,
                        onTap: () {
                          if (context.isPhone) {
                            final controller = Get.find<ViewNoteController>();
                            controller.setValue(e);
                            Get.toNamed(Routes.VIEW_NOTE);
                          } else {
                            final controller = Get.find<ViewNoteController>();
                            controller.setValue(e);
                          }
                        },
                        onRemove: () {
                          controller.removeNote(e.id);
                        },
                      ),
                    )
                    .toList(),
              );
      },
    );
  }
}
