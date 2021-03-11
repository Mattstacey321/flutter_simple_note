


class ApiClient {

  /*Future<User> signUp({int id, String userName, String password}) async {
    User user;
    try {
      final bodyData = {"id": id, "username": userName, "password": password};
      var response = await GetHttpClient().post(_connection.registerRoute, body: bodyData);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        user = User.fromJson(jsonResponse);
        return user;
      } else {
        return user;
      }
    } catch (e) {
      print(e);
      return user;
    }
  }*/

 /* Future backupData() async {  
    //NoteServices _noteServices = NoteServices();

    final userId = SettingController.to.user.id;
    final result = notes.map((e) => e.toJson()).toList();
    final bodyData = {"userId": userId, "data": result};
    try {
      var response = await GetHttpClient().put(
        _connection.noteRoute,
        body: bodyData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }*/

 
}
