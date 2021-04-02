import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_widgets/close_icon.dart';
import '../global_widgets/loading_button.dart';
import '../modules/authentication/widgets/input_field.dart';
import 'keyboard_shortcut.dart';
import 'keypad_icons.dart';

class DialogsUtil {
  Future _baseDialog({
    required double height,
    required double width,
    required String title,
    required List<Widget>? content,
    Function? onExit,
    Widget? confirmWidget,
    MainAxisAlignment childAlignment = MainAxisAlignment.spaceBetween,
    bool barrierDismissible = true,
    String barrierLabel = "",
    double padding = 10,
  }) async {
    Widget exitWidget = TextButton(
      onPressed: onExit == null ? () => Get.back() : () {},
      child: Text("Cancel"),
    );
    return Get.generalDialog(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FocusableActionDetector(
          autofocus: true,
          shortcuts: {escapeKeySet: CloseDialogIntent()},
          actions: {CloseDialogIntent: CallbackAction(onInvoke: (e) => Get.back())},
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: 1.seconds,
                height: height,
                width: width,
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(
                      parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                  child: Column(
                    mainAxisAlignment: childAlignment,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        title,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    right: 5,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CloseIcon(
                                        onTap: () => Get.back(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      for (var item in content!) item,
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [exitWidget, confirmWidget!],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.translate(
          offset: Offset(animation.value, animation.value * 15),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
    );
  }

  Future enterCode({required Function(String) onConfirm}) async {
    final codeCtrl = TextEditingController();
    return _baseDialog(
      height: 150,
      width: 300,
      title: "Enter code",
      onExit: () {
        Get.back(closeOverlays: true);
      },
      confirmWidget: TextButton(
        onPressed: onConfirm(codeCtrl.text),
        child: Text("Verify"),
      ),
      content: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: TextField(
            controller: codeCtrl,
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(hintText: "Paste here"),
          ),
        ),
      ],
    );
  }

  Future cancelSignUp({required Function() onExit}) async {
    return _baseDialog(
      height: 100,
      width: 300,
      title: "Confirm Exit ?",
      confirmWidget: TextButton(
        onPressed: onExit,
        child: Text("Back to login"),
      ),
      content: [],
    );
  }

  Future logOutDialog({required Function() onLogOut}) async {
    return _baseDialog(
      height: 125,
      width: 300,
      title: "Log out ?",
      confirmWidget: TextButton(
        onPressed: onLogOut,
        style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.red),
        child: Text("OK"),
      ),
      content: [],
    );
  }

  Future loadingDialog() async {
    return Get.dialog(
      Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }

  Future removeNoteDialog({LoadingButtonController? loadingCtrl, Function()? onRemove}) async {
    return _baseDialog(
      height: 140,
      width: 300,
      title: "Remove item ?",
      confirmWidget: LoadingButton(
        controller: loadingCtrl!,
        height: 30,
        width: 80,
        onPressed: onRemove!,
        radius: 10,
        buttonColor: Colors.red,
        initialWidget: Text("Remove"),
      ),
      content: [],
    );
  }

  Future viewShortcutCommand() {
    return _baseDialog(
      height: 250,
      width: 350,
      childAlignment: MainAxisAlignment.spaceEvenly,
      padding: 20,
      title: "Keyboard Command",
      content: [
        Row(
          children: <Widget>[
            Text(
              "Save Note",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[KeypadIcons.control, SizedBox(width: 5), KeypadIcons.keyS],
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Text(
              "New Note",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[KeypadIcons.control, SizedBox(width: 5), KeypadIcons.keyN],
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Text(
              "Go to search bar",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[KeypadIcons.control, SizedBox(width: 5), KeypadIcons.keyL],
            )
          ],
        )
      ],
    );
  }

  Future confirmOfflineMode({Function()? onConfirm}) async {
    return _baseDialog(
      height: 100,
      width: 300,
      title: "Switch Offline Mode",
      confirmWidget: TextButton(
        onPressed: onConfirm,
        child: Text("Change"),
      ),
      content: [],
    );
  }

  Future addFolder(
      {required LoadingButtonController loadingCtrl, required Function(String, String) onAdd}) async {
    final nameCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();
    return _baseDialog(
      height: 300,
      width: 450,
      title: "Create Folder",
      confirmWidget: LoadingButton(
        controller: loadingCtrl,
        height: 35,
        width: 100,
        onPressed: () => onAdd(nameCtrl.text, descriptionCtrl.text),
        radius: 10,
        buttonColor: Colors.indigo,
        initialWidget: Text("Add"),
      ),
      content: [
        InputField(
          hintText: "Name",
          contentAlign: TextAlignVertical.center,
          controller: nameCtrl,
          onSubmited: (value) {},
          onChanged: (value) {},
        ),
        SizedBox(height: 10),
        InputField(
          hintText: "Description",
          height: 100,
          controller: descriptionCtrl,
          contentAlign: TextAlignVertical.top,
          onSubmited: (value) {},
          onChanged: (value) {},
        ),
      ],
    );
  }

  Future editFolder(
      {required LoadingButtonController? loadingCtrl,
      required String? name,
      required String? description,
      required Function(String, String) onEdit}) {
    final nameCtrl = TextEditingController(text: name);
    final descriptionCtrl = TextEditingController(text: description);
    return _baseDialog(
      height: 300,
      width: 450,
      title: "Create Folder",
      confirmWidget: LoadingButton(
        controller: loadingCtrl!,
        height: 35,
        width: 100,
        onPressed: () => onEdit(nameCtrl.text, descriptionCtrl.text),
        radius: 10,
        buttonColor: Colors.indigo,
        initialWidget: Text("Add"),
      ),
      content: [
        InputField(
          hintText: "Name",
          contentAlign: TextAlignVertical.center,
          controller: nameCtrl,
          onSubmited: (value) {},
          onChanged: (value) {},
        ),
        SizedBox(height: 10),
        InputField(
          hintText: "Description",
          height: 100,
          controller: descriptionCtrl,
          contentAlign: TextAlignVertical.top,
          onSubmited: (value) {},
          onChanged: (value) {},
        ),
      ],
    );
  }

  Future removeFolder(
      {@required LoadingButtonController? loadingCtrl, String? deleteNotify, Function()? onRemove}) {
    return _baseDialog(
      height:  deleteNotify != null ? 180 : 150,
      width: 300,
      title: "Remove Folder",
      confirmWidget: LoadingButton(
        controller: loadingCtrl!,
        height: 35,
        width: 100,
        onPressed: () => onRemove!(),
        radius: 10,
        buttonColor: Colors.red,
        initialWidget: Text("Remove"),
      ),
      content: [
        // show text when folder has 1 more note
        deleteNotify != null
            ? Text(
                deleteNotify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox()
      ],
    );
  }

    Future confirmRemoveImage({Function()? onRemove}) async {
    return _baseDialog(
      height: 150,
      width: 300,
      title: "Remove ?",
      confirmWidget: TextButton(
        onPressed: onRemove,
        child: Text("OK"),
      ),
      content: [],
    );
  }
}
