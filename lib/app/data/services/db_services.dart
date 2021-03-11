import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_note/app/data/db/local_db.dart';

Future initServices() async {
  await Get.putAsync(() => DbServices().initHive());
}

Future initSreenSize() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // setWindowMinSize(Size(720, 720));
    // setWindowMaxSize(Size.infinite);
  }
}

class DbServices extends GetxService {
  
  Future initHive() async {
    Directory directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
    // init config
    await LocalDb.init();
  }

  Future initSetting() async {
   // final desktopMode = true;
    
  }

}
