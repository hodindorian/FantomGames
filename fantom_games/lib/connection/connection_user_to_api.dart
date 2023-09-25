import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password) async {
  String sha256Password = sha256.convert(utf8.encode(password)).toString();
  Uri uri = Uri.https('/codefirst.iut.uca.fr',
    '/containers/fantom_games-deploy_api/getUserPassword/$pseudo');
  http.Response response = await http.post(uri,
    headers: <String, String>{
      'Access-Control-Allow-Origin': '*',
    },
  );
  print(jsonDecode(response.body));
  if (response.statusCode != 200) {
    return "error";
  } else if (jsonDecode(response.body) == sha256Password){
    return "OK";
  }
  return "error";
}

