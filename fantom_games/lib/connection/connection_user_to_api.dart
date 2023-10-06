import 'package:crypto/crypto.dart';
import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password, bool stayConnected) async {
  try {
    String sha256Password = sha256.convert(utf8.encode(password)).toString();
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/userConnection/$pseudo/$sha256Password/$stayConnected');
    http.Response response = await http.get(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    try {
      var rep = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return "error";
      } else if (rep[0]['pseudo'] == pseudo) {
        if (stayConnected){
          print(rep[0]['id']);
          setSession("id", rep[0]['id']);
          setSession("pseudo", pseudo);
        }
        return "OK";
      } else {
        return "wrong_password";
      }
    } on Error catch (_) {
      String rep = response.body.replaceAll(' ', '');
      if (rep=='["OK"]'){
        return "OK";
      }else if(rep=='["wrongpassword"]') {
        return "wrong_password";
      }else{
        return "error";
      }
    }
  }catch(e) {
    return e.toString();
  }
}

