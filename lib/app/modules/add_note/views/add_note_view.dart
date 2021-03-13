import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/loading_button.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
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
        ),
      ),
    );
  }
}
