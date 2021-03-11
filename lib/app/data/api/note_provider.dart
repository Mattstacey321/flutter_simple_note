import 'dart:convert';

import 'package:get/get.dart';
import 'package:simple_note/app/data/config/connection.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/data/services/note_services.dart';

class NoteProvider extends GetConnect {
  Connection _connection = Connection();
  AuthServices _authServices = AuthServices();
  NoteServices _noteServices = NoteServices();
  @override
  void onInit() {
    //httpClient.baseUrl = _connection.baseUrl;
    httpClient.defaultDecoder = Note.listFromJson;
  }

  String get url => _connection.noteRoute;

  Future<Response<List<Note>>> getNotes() async {
    final userId = _authServices.getUser.id.toString();
    return get<List<Note>>(url, headers: {"user_id": userId}, decoder: Note.listFromJson);
  }

  Future<Response> updateNote(Note note) async {
    final bodyData = json.encode(note.toJson());
    final pactchNoteUrl = url + "/${note.id}";
    return put(pactchNoteUrl, bodyData);
  }

  Future<Response> saveToDb() async {
    final notes = _noteServices.getNotes();
    final userId = _authServices.getUser.idAsString;
    final result = json.encode(notes.map((e) => e.toJson()).toList());
    final bodyData = {"userId": userId, "data": result};
    return put(url, bodyData);
  }
}
