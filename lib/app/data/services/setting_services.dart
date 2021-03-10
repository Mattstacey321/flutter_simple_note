import 'package:hive/hive.dart';
import 'package:simple_note/app/data/constraints/hive_box_name.dart';

class SettingServices {
  var settingBox = Hive.openBox(HiveBoxName.setting);
}
