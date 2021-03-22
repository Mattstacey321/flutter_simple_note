import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/attribute.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:simple_note/app/modules/view_note/widgets/custom_quill_toolbar.dart';

import '../../../global_widgets/loading_button.dart';
import '../../../utils/keyboard_shortcut.dart';
import '../controllers/view_note_controller.dart';

class ViewNoteDesktop extends GetView<ViewNoteController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isChangeAnything = controller.isAnyThingChange.value;
        return FocusableActionDetector(
          autofocus: true,
          shortcuts: {saveNoteKeySet: SaveNoteIntent()},
          actions: {
            SaveNoteIntent: CallbackAction(
              onInvoke: (_) => isChangeAnything ? controller.updateNote() : () {},
            )
          },
          child: Scaffold(
            floatingActionButton: AnimatedSwitcher(
              duration: 200.milliseconds,
              child: isChangeAnything
                  ? LoadingButton(
                      controller: controller.saveBtnCtrl,
                      height: 60,
                      width: 60,
                      radius: 1000,
                      onPressed: () {
                        controller.updateNote();
                      },
                      initialWidget: Icon(
                        EvaIcons.save,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: controller.obx(
                  (state) => Column(
                    children: <Widget>[
                      TextField(
                        controller: controller.titleCtrl,
                        onChanged: (value) => controller.onTextChange(),
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration.collapsed(hintText: "Title"),
                      ),
                      SizedBox(height: 30),
                      //TODO: Cho phép link ngay chỗ đó tới url hay 1 vị trí gì đó
                      Expanded(
                        child: FocusableActionDetector(
                          shortcuts: {undoRemoveText: UndoRemoveText()},
                          actions: {
                            UndoRemoveText: CallbackAction(
                              onInvoke: (_) => {controller.undoRemoveText()},
                            ),
                          },
                          child: Column(
                            children: [
                              CustomQuillToolbar(controller: controller.quillCtrl),
                              Divider(),
                              Flexible(
                                child: Scrollbar(
                                  controller: controller.quillScrollCtl,
                                  showTrackOnHover: true,
                                  child: QuillEditor(
                                    focusNode: FocusNode(),
                                    scrollable: true,
                                    expands: true,
                                    autoFocus: true,
                                    showCursor: true,
                                    padding: EdgeInsets.all(0),
                                    scrollController: controller.quillScrollCtl,
                                    controller: controller.quillCtrl,
                                    readOnly: false, // change to true to be view only mode
                                  ),
                                ),
                              ),
                            ],
                          ),
                          /*TextField(
                            controller: controller.contentCtrl,
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            onChanged: (value) => controller.onTextChange(),
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
                          ),*/
                        ),
                      ),
                    ],
                  ),
                  onEmpty: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        EvaIcons.fileText,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "No note open",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
