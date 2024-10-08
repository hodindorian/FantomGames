import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> tryConnectionWithSession(String id, String pseudo, String idComputer) async {

  List<dynamic> result = [];
  Map<String, String> requestBody = {
    'id': id,
    'pseudo': pseudo,
    'idComputer': idComputer
  };
  try {
    Uri uri = Uri.https('apiuser.hodindorian.com',
        '/userForId',
    );
    String requestBodyJson = jsonEncode(requestBody);
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    try {
      var rep = jsonDecode(response.body);
      rep=rep[0];
      if (rep == "wrong id/pseudo couple") {
        result.add(false);
        result.add("cookie");
        return result;
      } else if (rep == "already connected"){
        result.add(false);
        result.add("already connected");
        return result;
      } else if (response.statusCode != 200) {
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
