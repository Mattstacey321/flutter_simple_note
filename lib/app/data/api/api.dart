import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:simple_note/app/data/models/auth_reponse.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/modules/setting/controllers/setting_controller.dart';

class ApiClient {
  String _registerPath = "http://192.168.123.107:3030/api/register";
  String _authPath = "http://192.168.123.107:3030/api/auth";
  String _notePath = "http://192.168.123.107:3030/api/note";

  Future<AuthResponse> authWithGithub(String code) async {
    try {
      var response = await GetHttpClient().post(_authPath, body: {"code": code});
      if (!(response.statusCode == 400)) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        AuthResponse authResponse = AuthResponse.fromJson(jsonResponse);
        return authResponse;
      } else
        return null;
    } on HttpException catch (_) {
      return null;
    }
  }

  Future<User> signUp({int id, String userName, String password}) async {
    User user;
    try {
      final bodyData = {"id": id, "userName": userName, "password": password};
      var response = await GetHttpClient().post(_registerPath, body: bodyData);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        user = User.fromJson(jsonResponse);
        return user;
      } else {
        return user;
      }
    } catch (e) {
      print(e);
      return user;
    }
  }

  Future backupData(List<Note> notes) async {
    final userId = SettingController.to.user.value.id;
    final result = notes.map((e) => e.toJson()).toList();
    final bodyData = {"userId": userId, "data": result};
    try {
      var response = await GetHttpClient().put(
        _notePath,
        body: bodyData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getNotes() async {
    var notes = <Note>[];
    try {
      var response = await GetHttpClient().get(_notePath);
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        for (var item in a) {
          notes.add(Note.fromJson(item));
        }
        return notes;
      }
    } catch (e) {
      printError(info: e);
      return notes;
    }
  }
}
