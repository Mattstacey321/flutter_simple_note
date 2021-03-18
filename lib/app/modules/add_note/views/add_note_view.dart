import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/loading_button.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<AddNoteController>(
              init: AddNoteController(
                  noteProvider: Get.find(), noteServices: Get.find(), folderServices: Get.find()),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ObxValue(
                      (res) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                            onTap: () {},
                            hint: Text("Select folder"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            items: controller.folderNames
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
                            value: controller.folderNames[res.value],
                            onChanged: (value) {
                              controller.setFolderId(value);
                            },
                          ),
                        );
                      },
                      controller.selectedIndex,
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: controller.titleCtrl,
                      decoration: InputDecoration.collapsed(hintText: "Title"),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: TextField(
                        controller: controller.contentCtrl,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: "Content",
                          contentPadding: EdgeInsets.all(0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent)),
                        ),
                      ),
                    ),
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
                        /*ElevatedButton(
                  onPressed: () {
                    controller.addNote();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  child: Text("Create"),
                )*/
                      ],
                    )
                  ],
                );
              })),
    );
  }
}
