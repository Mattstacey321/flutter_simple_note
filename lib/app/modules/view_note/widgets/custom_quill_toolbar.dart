import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/attribute.dart';
import 'package:flutter_quill/models/documents/nodes/embed.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:get/get.dart';

class CustomQuillToolbar extends StatelessWidget {
  final QuillController? controller;
  CustomQuillToolbar({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(
              color: isToggled! ? Colors.white : Colors.grey,
              icon: Icon(icon, size: 22),
              splashRadius: 20,
              onPressed: onPressed,
            );
          },
          controller: controller!,
        ),
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(
              color: isToggled! ? Colors.white : Colors.grey,
              icon: Icon(icon, size: 22),
              splashRadius: 20,
              onPressed: onPressed,
            );
          },
          controller: controller!,
        ),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          controller: controller!,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(
              color: isToggled! ? Colors.white : Colors.grey,
              icon: Icon(icon, size: 22),
              splashRadius: 20,
              onPressed: onPressed,
            );
          },
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            thickness: 2,
            width: 20,
          ),
        ),
        ColorButton(
          icon: Icons.color_lens,
          background: false,
          controller: controller!,
        ),
        IconButton(
          icon: Icon(Icons.image, size: 20),
          splashRadius: 20,
          onPressed: () async {
            final index = controller!.selection.baseOffset;
            final length = controller!.selection.extentOffset - index;
            // check platform
            if (GetPlatform.isMobile) {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                final path = result.files.single.path!;
                return controller!.replaceText(index, length, BlockEmbed.image(path), null);
              }
            } else {
              final typeGroup = XTypeGroup(label: 'images', extensions: ['jpg', 'png']);
              final file = await openFile(acceptedTypeGroups: [typeGroup]);
              if (file != null)
                return controller!.replaceText(index, length, BlockEmbed.image(file.path), null);
            }
          },
        ),
      ],
    );
  }
}
