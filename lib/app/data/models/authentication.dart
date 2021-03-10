import 'package:hive/hive.dart';
part 'authentication.g.dart';

@HiveType(typeId: 0)
class Authentication extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userName;
  Authentication({this.id, this.userName});
}
