import 'dart:convert';
import 'dart:js';
import 'package:fantom_games/model/global_account.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<dynamic>> tryConnectionWithSession(int id, String pseudo) async {
  try {
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/userForId/$id');
    http.Response response = await http.get(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    try {
      var rep = jsonDecode(response.body);
      rep=rep[0];

      if (response.statusCode != 200) {
        result.add(false);
        return rep;
      } else if (rep['pseudo'] == pseudo) {
        rep.add(true);
        rep.add(rep['email']);
        rep.add, rep['pseudo'], rep['lastname'], rep['firstname'], rep['phoneNumber'],rep['gameLevel'],rep['cryptoBalance'])
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
    }
  }catch(e) {
    return false;
  }
}
