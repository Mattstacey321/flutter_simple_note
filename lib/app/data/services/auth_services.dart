import 'package:hive/hive.dart';
import 'package:simple_note/app/data/constraints/hive_box_name.dart';
import 'package:simple_note/app/data/models/user.dart';

class AuthServices {
  var authBox = Hive.box(HiveBoxName.authentication);

  bool get isLogin => authBox.get("user") == null ? false : true;
  User get user => authBox.get("user");

  void setLogin(User user) {
    authBox.put("user", user);
  }

  bool removeInfo() {
    try {
      authBox.delete("user");
      return true;
    } catch (e) {
      return false;
    }
  }
}
