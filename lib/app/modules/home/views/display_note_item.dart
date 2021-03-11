import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_note/app/data/constraints/hive_box_name.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/modules/home/controllers/home_controller.dart';
import 'package:simple_note/app/modules/home/widgets/note_item.dart';
import 'package:simple_note/app/modules/view_note/controllers/view_note_controller.dart';
import 'package:simple_note/app/routes/app_pages.dart';
import 'package:simple_note/app/utils/navigator_key_utils.dart';

class DisplayNoteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    var noteBox = Hive.box<Note>(HiveBoxName.note);
    return Scaffold(
      floatingActionButton: ObxValue<RxList<Note>>(
        (res) {
          return AnimatedSwitcher(
            duration: 200.milliseconds,
            child: res.isEmpty
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(
                        Routes.ADD_NOTE,
                        id: NavigatorKeyUtils.leftSideNavigator,
                      );
                    },
                    child: Icon(EvaIcons.plus, color: Colors.white),
                  ),
          );
        },
        controller.notes,
      ),
      body: Center(
        child: controller.obx(
          (state) => ValueListenableBuilder(
            valueListenable: noteBox.listenable(),
            builder: (context, Box<Note> noteBox, child) {
              var notes = noteBox.values.toList();
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                padding: EdgeInsets.all(20),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: notes
                    .map((e) => NoteItem(
                        item: e,
                        onTap: () {
                          final controller = Get.find<ViewNoteController>();
                          controller.setValue(e);
                        }))
                    .toList(),
              );
            },
          ),
          onEmpty: _emptyState(),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Oops! There are no notes \nthat you have created",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            Get.toNamed(Routes.ADD_NOTE, id: NavigatorKeyUtils.leftSideNavigator);
          },
          icon: Icon(EvaIcons.plus),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(130, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          label: Text("Create Note"),
        )
      ],
    );
  }
}
