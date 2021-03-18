import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/keyboard_shortcut.dart';
import '../../login/widgets/input_field.dart';
import '../controllers/home_controller.dart';

class NoteSearchBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      onFocusChange: (value) {
        print(value);
      },
      focusNode: controller.searchFieldNode,
      shortcuts: {searchNoteKeySet: SearchNoteIntent()},
      actions: {
        SearchNoteIntent: CallbackAction(
          onInvoke: (e) {
            controller.searchNote(context);
            return e;
          },
        )
      },
      child: Container(
        height: 50,
        child: InputField(
          controller: controller.searchCtrl,
          focusNode: controller.searchFocusNode,
          width: Get.width,
          borderRadius: 10,
          hintText: "Search",
          prefixIcon: Icon(
            EvaIcons.search,
            color: Colors.white,
          ),
          onChanged: (value) => controller.onSearch(value),
          onSubmited: (value) {},
        ),
      ),
    );
  }
}
