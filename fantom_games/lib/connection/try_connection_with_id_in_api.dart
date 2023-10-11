import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> tryConnectionWithSession(int id, String pseudo) async {

  List<dynamic> result = [];
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
        return result;
      } else if (rep['pseudo'] == pseudo) {
        result.add(true);
        result.add(rep['email']);
        result.add(rep['pseudo']);
        result.add(rep['lastname']);
        result.add(rep['firstname']);
        result.add(rep['phoneNumber']);
        result.add(rep['gameLevel']);
        result.add(rep['cryptoBalance']);
        return result;
      } else {
        result.add(false);
        return result;
      }
    } on Error catch (_) {
      result.add(false);
      return result;
    }
  }catch(e) {
    result.add(false);
    return result;
  }
}
