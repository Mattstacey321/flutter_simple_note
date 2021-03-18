import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';
import '../models/folder.dart';

class FolderServices {
  var folderBox = Hive.box<Folder>(HiveBoxName.folder);

  List<Folder> getAll() {
    return folderBox.values.toList();
  }


  Folder getById(String id) {
    return folderBox.get(id);
  }


  void add(Folder folder) {
    folderBox.put(folder.id, folder);
  }

  void remove(String id) {
    folderBox.delete(id);
  }

  void updateOne(Folder folder) {
    folderBox.get(folder.id)
      ..name = folder.name
      ..save();
  }

  void updateMany(List<Folder> notes) {
    for (var item in notes) {
      if (folderBox.containsKey(item.id)) {
        updateOne(item);
      } else
        folderBox.put(item.id, item);
    }
  }

}
