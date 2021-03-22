import 'package:bot_toast/bot_toast.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/attribute.dart';
import 'package:flutter_quill/models/documents/nodes/embed.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'dart:io' show Platform;

class CustomQuillToolbar extends StatelessWidget {
  final QuillController controller;
  CustomQuillToolbar({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return Material(
              child: InkWell(
                focusColor: Colors.amber,
                onTap: onPressed,
                child: Container(
                  child: Icon(icon, size: 20),
                ),
              ),
            );
          },
          controller: controller,
        ),
        SizedBox(width: 10),
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return Material(
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  child: Icon(icon, size: 20),
                ),
              ),
            );
          },
          controller: controller,
        ),
        SizedBox(width: 10),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          controller: controller,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return Material(
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  child: Icon(icon, size: 20),
                ),
              ),
            );
          },
        ),
        SizedBox(width: 10),
        ColorButton(
          icon: Icons.color_lens,
          background: false,
          controller: controller,
        ),
        SizedBox(width: 10),
        IconButton(
            icon: Icon(Icons.image),
            onPressed: () async {
              if (Platform.isWindows) {
                final index = controller.selection.baseOffset;
                final length = controller.selection.extentOffset - index;

                final file = OpenFilePicker()
                  ..filterSpecification = {'Image (*.img;*.jpg;*.png)': '*.img;*.jpg;*.png'}
                  ..defaultFilterIndex = 0
                  ..defaultExtension = 'jpg'
                  ..title = 'Select image';
                final result = file.getFile();
                if (result != null)
                  return controller.replaceText(index, length, BlockEmbed.image(result.path), null);
              } else {
                BotToast.showText(text: "Unsupport platform");
              }
            }),
      ],
    );
  }
}
