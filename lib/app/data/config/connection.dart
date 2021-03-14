class Connection {
  bool isProduction = true;
  String localUrl = "http://192.168.123.107:3030/api";
  String remoteUrl = "https://simple-note-server.glitch.me";
  
  String get registerRoute => (isProduction ? remoteUrl : localUrl )+ "/register";
  String get authRoute => (isProduction ? remoteUrl : localUrl) + "/auth";
  String get noteRoute => (isProduction ? remoteUrl : localUrl) + "/note";
  String get loginRoute =>(isProduction ? remoteUrl : localUrl) + "/login";
}
