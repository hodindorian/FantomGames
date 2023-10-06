import 'package:http/http.dart' as http;

Future<String> tryConnectionWithSession(int id) async {
  try {
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/userForId/$id');
    http.Response response = await http.get(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      return "error";
    } else {

      return response.body.toString();
    }
  }catch(e) {
    return e.toString();
  }
}
