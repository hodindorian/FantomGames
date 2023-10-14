import 'package:http/http.dart' as http;
import 'dart:async';
import '../reusable_widget/salt_hash_password.dart';

Future<String> creatingUserInApi(String email,String pseudo, String password) async {
  try {
    String hashSaltPassword = hashPassword(password);
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/addUser/$email/$pseudo/$hashSaltPassword');
    http.Response response = await http.post(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      return "error";
    }
    return response.body;
  }catch(e){
    return e.toString();
  }
}

