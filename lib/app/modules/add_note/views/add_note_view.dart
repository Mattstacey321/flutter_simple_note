import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:get/get.dart';

import '../../../global_widgets/embed_builder.dart';
import '../../../global_widgets/loading_button.dart';
import '../../home/widgets/folder_name_dropdown_button.dart';
import '../../view_note/widgets/custom_quill_toolbar.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetBuilder<AddNoteController>(
          init: AddNoteController(
            noteProvider: Get.find(),
            noteServices: Get.find(),
            folderServices: Get.find(),
          ),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FolderNameDropDownButton(
                  dataSource: controller.folderNames,
                  onSelected: (value, index, _) => controller.setFolderId(value),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.titleCtrl,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration.collapsed(
                      hintText: "Title", hintStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      CustomQuillToolbar(controller: controller.quillController),
                      SizedBox(height: 10),
                      Flexible(
                        child: QuillEditor(
                          focusNode: FocusNode(),
                          scrollable: true,
                          expands: true,
                          autoFocus: false,
                          showCursor: true, placeholder: "Content",
                          embedBuilder: (context, node) => EmbedBuilder(node),
                          padding: EdgeInsets.all(0),
                          scrollController: ScrollController(),
                          controller: controller.quillController,
                          readOnly: false, // change to true to be view only mode
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        controller.onClosePage();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 50),
                          primary: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      child: Text("Close"),
                    ),
                    LoadingButton(
                      controller: controller.createBtnCtrl,
                      height: 50,
                      width: 100,
                      onPressed: () {
                        controller.addNote();
                      },
                      initialWidget: Text("Create"),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
