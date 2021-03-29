import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/attribute.dart';
import 'package:flutter_quill/models/documents/nodes/embed.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/toolbar.dart';

class CustomQuillToolbar extends StatelessWidget {
  final QuillController? controller;
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
            return IconButton(
              color: isToggled! ? Colors.white : Colors.grey,
              icon: Icon(icon, size: 22),
              splashRadius: 20,
              onPressed: onPressed,
            );
          },
          controller: controller!,
        ),
        SizedBox(width: 10),
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
        SizedBox(width: 10),
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
        SizedBox(width: 10),
        ColorButton(
          icon: Icons.color_lens,
          background: false,
          controller: controller!,
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.image, size: 20),
          splashRadius: 20,
          onPressed: () async {
            final index = controller!.selection.baseOffset;
            final length = controller!.selection.extentOffset - index;
            final typeGroup = XTypeGroup(label: 'images', extensions: ['jpg', 'png']);
            final file = await openFile(acceptedTypeGroups: [typeGroup]);
            if (file != null)
              return controller!.replaceText(index, length, BlockEmbed.image(file.path), null);
          },
        ),
      ],
    );
  }
}
