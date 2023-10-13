import 'package:crypto/crypto.dart';
import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<dynamic>> connectingUserToApi(String pseudo, String password, bool stayConnected) async {

  List<dynamic> result = [];

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
      if(response.statusCode != 200){
        result.add("error");
        result.add(response.toString());
        return result;
      }
      var rep = jsonDecode(response.body);
      rep=rep[0];
      if (rep == "no user") {
        result.add("no user");
        return result;
      } else if (rep == "wrong password"){
        result.add("wrong_password");
        return result;
      } else if (rep['pseudo'] == pseudo) {
        if (stayConnected){
          setSession("id", rep['id']);
          setSession("pseudo", pseudo);
        }
        result.add("OK");
        result.add(rep['email']);
        result.add(rep['pseudo']);
        result.add(rep['lastname']);
        result.add(rep['firstname']);
        result.add(rep['phoneNumber']);
        result.add(rep['gameLevel']);
        result.add(rep['cryptoBalance']);
        return result;
      } else{
        result.add("error unknown");
        return result;
      }
    } on Error catch (e) {
      result.add(e.toString());
      return result;
    }
  }catch(e) {
    result.add(e.toString());
    return result;
  }
}

