import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> creatingUserInApi(String email,String pseudo, String password) async {
  String sha256Password = sha256.convert(utf8.encode(password)).toString();
  Uri uri = Uri.https('codefirst.iut.uca.fr',
      '/containers/fantom_games-deploy_api/addUser/$email/$pseudo/$sha256Password');
  http.Response response = await http.post(uri);
  print(response.statusCode);
  print(response.body);
  print(response.headers);
  if (response.statusCode != 200) {
    return "error";
  }
  return response.body;
}

