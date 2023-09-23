import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password) async {
  String url = "https://codefirst.iut.uca.fr/containers/fantom_games-deploy_api/getUserPassword/$pseudo";
  String sha256Password = sha256.convert(utf8.encode(password)).toString();
  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  if (response.statusCode != 200) {
    return "error";
  } else if (jsonDecode(response.body) == sha256Password){
    return "OK";
  }
  return "error";
}

