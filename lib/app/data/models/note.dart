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
  DateTime createdTime;
  Note(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.createdTime});

  Note copyWith({String id, String title, String content, DateTime createdTime}) => Note(
        id: id ?? this.id,
        content: content ?? this.content,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
      );

  factory Note.fromJson(Map<String, Object> json) {
    return Note(
        id: json["id"],
        title: json["title"],
        content: json["content"] ?? "",
        createdTime: json["createdTime"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "content": this.content,
      "createdTime": this.createdTime.toIso8601String(),
    };
  }
}
