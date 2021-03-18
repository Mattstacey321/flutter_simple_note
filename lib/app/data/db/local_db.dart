import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';
import '../models/authentication.dart';
import '../models/folder.dart';
import '../models/note.dart';
import '../models/user.dart';

class LocalDb {
  static Future<void> init() async {
    Hive
      ..registerAdapter(AuthenticationAdapter())
      ..registerAdapter(UserAdapter())
      ..registerAdapter(NoteAdapter())
      ..registerAdapter(FolderAdapter());
    await Hive.openBox<User>(HiveBoxName.user);
    await Hive.openBox(HiveBoxName.authentication);
    await Hive.openBox(HiveBoxName.setting);
    await Hive.openBox<Note>(HiveBoxName.note);
    await Hive.openBox<Folder>(HiveBoxName.folder);
  }
}
