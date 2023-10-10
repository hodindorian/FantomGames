import 'package:crypto/crypto.dart';
import 'package:fantom_games/model/account.dart';
import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password, bool stayConnected) async {
  try {
    String sha256Password = sha256.convert(utf8.encode(password)).toString();
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/userConnection/$pseudo/$sha256Password');
    http.Response response = await http.get(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    try {
      var rep = jsonDecode(response.body);
      rep=rep[0];
      if (response.statusCode != 200) {
        return "error";
      } else if (rep['pseudo'] == pseudo) {
        if (stayConnected){
          setSession("id", rep['id']);
          setSession("pseudo", pseudo);
        }


        Account(rep['email'], rep['pseudo'], rep['lastname'], rep['firstname'], rep['phoneNumber'],rep['gameLevel'],rep['cryptoBalance']);
        return "OK";
      } else {
        return "wrong_password";
      }
    } on Error catch (e) {
      return e.toString();
    }
  }catch(e) {
    return e.toString();
  }
}

