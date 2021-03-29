import 'user.dart';

class AuthResponse {
  int status;
  String result;
  User user;
  AuthResponse({required this.status, required this.result, required this.user});
  /*factory AuthResponse.fromJson(Map json) {
    status = json["status"];
    result = json["result"];
    user = User.fromJson(json["data"]);
  }*/

  static AuthResponse fromJson(json) {
    return AuthResponse(
      result: json["result"],
      status: json["status"],
      user: User.fromJson(json["data"]),
    );
  }
}
