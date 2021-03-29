import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? folderId;
  @HiveField(3)
  String? content;
  @HiveField(4)
  DateTime? createdAt;
  @HiveField(5)
  DateTime? updatedAt;
  Note(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.createdAt,
      @required this.folderId,
      this.updatedAt});

  Note copyWith(
          {String? id, String? folderId, String? title, String? content, DateTime? createdAt}) =>
      Note(
        id: id ?? this.id,
        folderId: folderId ?? this.folderId,
        content: content ?? this.content,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );
      
  /*factory Note.fromNull() {
    return Note(id: null, title: null, content: null, createdAt: DateTime.now(), folderId: null);
  }*/

  static Note fromJson(json) {
    final response = jsonDecode(json);
    return Note(
      id: response["id"],
      folderId: response["folderId"] ?? null,
      title: response["title"],
      content: response["content"] ?? null,
      createdAt: DateTime.parse(
        response["createdAt"],
      ),
    );
  }

  static List<Note> listFromJson(json) {
    final listParse = jsonDecode(json);
    return List<Note>.from(
      listParse.map(
        (json) => Note(
          id: json["id"],
          folderId: json["folderId"] ?? null,
          title: json["title"],
          content: json["content"] ?? null,
          createdAt: DateTime.parse(
            json["createdAt"],
          ),
        ),
      ),
    );
  }

  String toJson() {
    return json.encode({
      "id": this.id,
      "folderId": this.folderId,
      "title": this.title,
      "content": this.content,
      "createdAt": this.createdAt.toString()
    });
  }
}
