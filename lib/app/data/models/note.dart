import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime createdAt;
   @HiveField(4)
  DateTime updatedAt;
  Note({@required this.id, @required this.title, @required this.content, @required this.createdAt, this.updatedAt});

  Note copyWith({String id, String title, String content, DateTime createdAt}) => Note(
        id: id ?? this.id,
        content: content ?? this.content,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );

  static List<Note> listFromJson(json) {
    final listParse = jsonDecode(json);
    return List<Note>.from(
      listParse.map(
        (json) => Note(
            id: json["id"],
            title: json["title"],
            content: json["content"] ?? "",
            createdAt: DateTime.parse(json["createdAt"])),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "content": this.content,
      "createdAt": this.createdAt.toString()
    };
  }
}
