import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? avatarUrl;

  String get idAsString => id.toString();

  User({this.id, this.name, this.email, this.avatarUrl});

  /*factory User.fromNull() {
    return User();
  }*/

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    avatarUrl = json['avatarUrl'] ?? null;
    name = json['displayName'] ?? null;
    email = json['email'] ?? null;
  }
}
