import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/constraints/app_state.dart';
import '../../../data/constraints/hive_box_name.dart';
import '../../../data/models/note.dart';
import '../../../global_widgets/custom_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/keyboard_shortcut.dart';
import '../../../utils/navigator_key_utils.dart';
import '../../side_bar/controllers/side_bar_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/add_note_button.dart';
import '../widgets/folder_name_dropdown_button.dart';
import '../widgets/note_item.dart';
import '../widgets/note_search_bar.dart';
import '../widgets/search_view.dart';

class DisplayNoteItem extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var noteBox = Hive.box<Note>(HiveBoxName.note);
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {newNoteKeySet: NewNoteIntent()},
      actions: {
        NewNoteIntent: CallbackAction(
          onInvoke: (e) {
            Get.toNamed(
              Routes.ADD_NOTE,
              id: NavigatorKeyUtils.leftSideNavigator,
            );
            return e;
          },
        )
      },
      child: Scaffold(
        appBar: CustomAppBar(
          childs: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: NoteSearchBar(),
            )
          ],
        ),
        floatingActionButton: AddNoteButton(),
        body: Center(
          child: controller.obx(
            (state) => Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Obx(
                () {
                  bool isOpen = SideBarController.to.openSidebar.value;
                  bool searchMode = controller.searchMode.value;
                  String folderId = controller.currentFolderId.value;
                  return searchMode
                      ? _buildSearchArea()
                      : _buildDisplayNoteArea(noteBox, isOpen: isOpen, folderId: folderId);
                },
              ),
            ),
            onEmpty: AppStates().emptyNote(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchArea() {
    return SearchView();
  }

  Widget _buildDisplayNoteArea(Box<Note> noteBox, {bool isOpen, String folderId}) {
    int crossAxisCOunt = isOpen ? 1 : 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FolderNameDropDownButton(),
        SizedBox(height: 10),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: noteBox.listenable(),
            builder: (context, Box<Note> noteBox, child) {
              List<Note> notes;
              if (folderId != null) {
                //show by folderId
                notes = noteBox.values.where((e) => e.folderId == folderId).toList();
              } else {
                //show all
                notes = noteBox.values.toList();
              }

              return notes.isEmpty
                  ? Center(child: Text("No Note"))
                  : GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: crossAxisCOunt,
                      childAspectRatio: context.isPhone
                          ? Get.width / (Get.height / 2.5)
                          : (isOpen
                              ? context.width / (context.height / 2)
                              : 2.5),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: notes
                          .map(
                            (e) => NoteItem(
                              item: e,
                              onTap: () {
                                controller.viewNote(context, e);
                              },
                              onRemove: () {
                                controller.removeNote(e.id);
                              },
                            ),
                          )
                          .toList(),
                    );
            },
          ),
        ),
      ],
    );
  }
}
