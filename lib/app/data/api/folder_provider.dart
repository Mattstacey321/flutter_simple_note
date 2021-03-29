import 'dart:convert';

import 'package:get/get.dart';

import '../config/connection.dart';
import '../models/folder.dart';
import '../services/auth_services.dart';

class FolderProvider extends GetConnect {
  Connection _connection = Connection();
  AuthServices _authServices = AuthServices();

  String get url => _connection.folderRoute;
  String get userId => _authServices.getUser.id.toString();

  Future<Response<List<Folder>>> getFolder() async {
    return get(url, headers: {"user_id": userId}, decoder: Folder.listFromJson);
  }

  Future<Response> addFolder(Folder folder) async {
    final bodyData = {"userId": userId, "data": folder.toJson()};
    return put(url, bodyData);
  }

  Future<Response> moveToFolder(String folderId, String noteId) async {
    final bodyData = {"userId": userId, "folderId": folderId, "noteId": noteId};
    return patch(url, bodyData);
  }

  Future<Response> editFolder(Folder folder) async {
    final bodyData = {"userId": userId, "data": folder.toJson()};
    return patch(url, bodyData);
  }

  Future<Response> removeFolder(String folderId, {List<String>? noteIds}) async {
    final bodyData = {"user_id": userId, "note_ids": jsonEncode(noteIds), "folder_id": folderId};
    return delete(url, headers: bodyData);
  }
}
