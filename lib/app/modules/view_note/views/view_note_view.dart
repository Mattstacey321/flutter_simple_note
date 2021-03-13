
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/view_note_controller.dart';
import '../responsive_view/view_note_desktop.dart';
import '../responsive_view/view_note_mobile.dart';

class ViewNoteItem extends GetResponsiveView<ViewNoteController> {
  ViewNoteItem() : super(alwaysUseBuilder: false);
  //final contr = Get.create(() => ViewNoteController(note: null));
  @override
  Widget desktop() => ViewNoteDesktop();

  @override
  Widget phone() => ViewNoteMobile();
}
