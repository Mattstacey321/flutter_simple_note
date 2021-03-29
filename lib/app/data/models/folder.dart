import 'dart:convert';

import 'package:hive/hive.dart';

part 'folder.g.dart';

@HiveType(typeId: 5)
class Folder extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime? createdAt;
  Folder({required this.id, required this.name, this.description, this.createdAt});

  Folder copyWith({String? id, String? name, String? description, DateTime? createdAt}) => Folder(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  static List<Folder> listFromJson(json) {
    final listParse = jsonDecode(json);
    return List<Folder>.from(
      listParse.map(
        (json) => Folder(
          id: json["id"],
          name: json["name"],
          description: json["description"],
          createdAt: DateTime.parse(
            json["createdAt"],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "createdAt": this.createdAt.toString()
    };
  }
}
