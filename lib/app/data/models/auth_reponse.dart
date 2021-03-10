import 'package:simple_note/app/data/models/user.dart';

class AuthResponse {
  int status;
  String result;
  User user;
  AuthResponse({this.status, this.result, this.user});
  AuthResponse.fromJson(Map json) {
    status = json["status"];
    result = json["result"];
    user = User.fromJson(json["data"]);
  }
}
