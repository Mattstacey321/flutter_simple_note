class Connection {
  bool isProduction = false;
  String localUrl = "http://192.168.123.107:3030";
  String remoteUrl = "https://simple-note-server.glitch.me";

  String get baseUrl => (isProduction ? remoteUrl : localUrl);

  String get registerRoute => baseUrl + "/register";
  String get authRoute => baseUrl + "/auth";
  String get noteRoute => baseUrl + "/note";
  String get loginRoute => baseUrl + "/login";
  String get folderRoute => baseUrl + "/folder";
}
