class Connection {
  String localUrl = "http://192.168.123.107:3030/api";
  String remoteUrl = "https://vercel-express-jade.vercel.app/api";
  bool isProduction = true;

  String get registerRoute => isProduction ? remoteUrl  : localUrl + "/register";
  String get authRoute => isProduction ? remoteUrl  : localUrl + "/auth";
  String get noteRoute => isProduction ? remoteUrl  : localUrl + "/note";
}
