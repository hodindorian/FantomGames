import 'package:http/http.dart' as http;
import 'dart:async';
import '../reusable_widget/salt_hash_password.dart';

Future<String> creatingUserInApi(String email,String pseudo, String password) async {
  try {
    String hashSaltPassword = hashPassword(password);
    String encodedMail = email.replaceAll('.', '\$&\$');
    Uri uri = Uri.https('apiuser.fantomgames.eu',
      'addUser/$encodedMail/$pseudo/$hashSaltPassword');
    http.Response response = await http.post(uri);
    if (response.statusCode != 200) {
      return "error";
    }
    return response.body;
  }catch(e){
    return e.toString();
  }
}

