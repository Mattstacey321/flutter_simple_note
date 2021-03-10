import 'package:hive/hive.dart';
import 'package:simple_note/app/data/constraints/hive_box_name.dart';
import 'package:simple_note/app/data/models/note.dart';

class NoteServices {
  var noteBox = Hive.box<Note>(HiveBoxName.note);

  List<Note> getNotes() {
    return noteBox.values.toList();
  }

  bool add(Note note) {
    try {
      final noteId = note.id;
      noteBox.put(
        noteId,
        note,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  remove(String id) {
    noteBox.delete(id);
  }

  update(Note note) {
    try {
      noteBox.get(note.id)
        ..content = note.content
        ..title = note.title
        ..save();
     /* test.copyWith(title: note.title, content: note.content);
      test.save();*/
      //noteBox.get(note.id).copyWith(title: note.title, content: note.content).save();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
