import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';
import '../models/user.dart';
import 'note_services.dart';

class AuthServices {
  var authBox = Hive.box(HiveBoxName.authentication);
  var noteServices = NoteServices();

  bool get isLogin => authBox.get("user") == null ? false : true;
  User get getUser => authBox.get("user");

  void setLogin(User user) {
    authBox.put("user", user);
  }

  void removeInfo() async {
    authBox.delete("user");
    await noteServices.removeAll();
  }
}
