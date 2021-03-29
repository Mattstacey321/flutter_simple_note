import 'dart:convert';
import 'dart:io';

import 'package:flutter_quill/models/documents/document.dart';
import 'package:get/get.dart';

import '../config/connection.dart';
import '../models/note.dart';
import '../services/auth_services.dart';
import '../services/note_services.dart';

class NoteProvider extends GetConnect {
  Connection _connection = Connection();
  AuthServices _authServices = AuthServices();
  NoteServices _noteServices = NoteServices();
  @override
  void onInit() {
    //httpClient.baseUrl = _connection.baseUrl;
    //httpClient.defaultDecoder = Note.listFromJson;
  }

  String get url => _connection.noteRoute;

  Future<Response<Note>> addNote(Note note, Document content) async {
    final userId = _authServices.getUser.id.toString();
    final document = content.toDelta().toJson();

    final imagePath = document.where((e) => e.value is Map).map((e) => e.value["image"]);
    //final imagePath = imagesMap.map<String>((e) => e.value["image"]);

    // check platform
    final forms = imagePath.map((path) {
      final file = File(path).readAsBytesSync();
      return MultipartFile(file, filename: path.split("/").last);
    }).toList();

    final bodyData = {
      "userId": userId,
      "folderId": note.folderId,
      "data": note.toJson(),
      "document": jsonEncode(document),
      "image": forms.toList()
    };
    // uploadFiles.addAll(bodyData);
    final multipart = FormData(bodyData);
    return post(url, multipart, decoder: Note.fromJson);
  }

  Future<Response<List<Note>>> getNotes() async {
    final userId = _authServices.getUser.id.toString();
    return get<List<Note>>(url, headers: {"user_id": userId}, decoder: Note.listFromJson);
  }

  Future<Response> updateNote(Note note) async {
    final bodyData = json.encode(note);
    final pactchNoteUrl = url + "/${note.id}";
    return patch(pactchNoteUrl, bodyData);
  }

  Future<Response> saveToDb() async {
    final notes = _noteServices.getNotes();
    final userId = _authServices.getUser.idAsString;
    final result = json.encode(notes.map((e) => e.toJson()).toList());
    final bodyData = {"userId": userId, "data": result};
    return put(url, bodyData);
  }

  Future<Response> removeNote(List<String> noteIds) async {
    final bodyData = json.encode(noteIds);
    return delete(url, headers: {"ids": bodyData});
  }
}
