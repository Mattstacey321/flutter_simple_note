import 'package:get/get.dart';

import '../config/connection.dart';
import '../models/auth_reponse.dart';

class AuthProvider extends GetConnect {
  Connection connection = Connection();
  @override
  void onInit() {
    //httpClient.baseUrl = connection.baseUrl;
    httpClient.defaultDecoder = AuthResponse.fromJson;
  }

  String get url => connection.authRoute;
  String get loginUrl => connection.loginRoute;
  String get registerUrl => connection.registerRoute;

  Future<Response> authWithGithub(String code) async {
    final bodyData = {"code": code};
    return post(url, bodyData, decoder: AuthResponse.fromJson);
  }

  Future<Response> logIn(String userName, String password) async {
    final bodyData = {"username": userName, "password": password};
    return post(loginUrl, bodyData, decoder: AuthResponse.fromJson);
  }

  Future<Response<AuthResponse>> signUp(
      {required int id, required String userName, required String password}) async {
    final bodyData = {"id": id, "username": userName, "password": password};
    return post(registerUrl, bodyData, decoder: AuthResponse.fromJson);
  }
}
