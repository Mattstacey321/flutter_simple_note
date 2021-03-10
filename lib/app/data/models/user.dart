import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  @HiveField(4)
  String avatarUrl;
  User({this.id, this.name, this.email, this.avatarUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarUrl = json['avatar_url'];
    name = json['name'];
    email = json['email'] ?? null;
  }
}
