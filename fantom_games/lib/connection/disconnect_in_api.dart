import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> disconnectInApi(String pseudo) async {
  try {
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        'disconnected/$pseudo'
    );
    http.Response response = await http.post(uri);
    String res = response.body.replaceAll(' ', '');
    if (response.statusCode != 200 || res == "error") {
      return "error";
    }else if (res == "notWorking"){
      return "unexpected error, aled";
    }else if (res == "OK"){
      return "";
    }else {
      return "no case";
    }
  }catch(e){
    return e.toString();
  }
}

