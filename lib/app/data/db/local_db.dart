import 'package:hive/hive.dart';
import 'package:simple_note/app/data/constraints/hive_box_name.dart';
import 'package:simple_note/app/data/models/authentication.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/models/user.dart';

class LocalDb {
  static Future<void> init() async {
    Hive
      ..registerAdapter(AuthenticationAdapter())
      ..registerAdapter(UserAdapter())
      ..registerAdapter(NoteAdapter());
    await Hive.openBox<User>(HiveBoxName.user);
    await Hive.openBox(HiveBoxName.authentication);
    await Hive.openBox(HiveBoxName.setting);
    await Hive.openBox<Note>(HiveBoxName.note);
  }
}
