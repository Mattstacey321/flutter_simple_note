import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final escapeKeySet = LogicalKeySet(LogicalKeyboardKey.escape);

class CloseDialogIntent extends Intent {}

final saveNoteKeySet = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS);

class SaveNoteIntent extends Intent {}

final newNoteKeySet = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN);

class NewNoteIntent extends Intent {}

final searchNoteKeySet = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyL);

class SearchNoteIntent extends Intent {}
