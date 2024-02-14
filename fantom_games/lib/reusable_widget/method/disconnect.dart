import 'package:fantom_games/connection/disconnect_in_api.dart';
import 'package:fantom_games/reusable_widget/method/cookie_managing.dart';

void disconnect(String pseudo){
  disconnectInApi(pseudo);
  deleteCookie("id");
  deleteCookie("pseudo");
  deleteCookie("idComputer");

}