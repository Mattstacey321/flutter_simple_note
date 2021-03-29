import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';
import '../models/note.dart';

class NoteServices {
  var noteBox = Hive.box<Note>(HiveBoxName.note);

  List<Note> getNotes() {
    return noteBox.values.toList();
  }

  void add(Note note) {
    final noteId = note.id;
    noteBox.put(
      noteId,
      note,
    );
  }

  void remove(String id) {
    noteBox.delete(id);
  }

  void removeMany(List<String> ids){
    for (var id in ids) {
        noteBox.delete(id);
    }
    
  }

  Future<void> removeAll() async{
    await noteBox.clear();
  }

  void updateOne(Note note) {
    noteBox.get(note.id)!
      ..content = note.content
      ..title = note.title
      ..save();
  }

  void updateMany(List<Note> notes) {
    for (var item in notes) {
      if (noteBox.containsKey(item.id)) {
        updateOne(item);
      } else
        noteBox.put(item.id, item);
    }
  }
}
