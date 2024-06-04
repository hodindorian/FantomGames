import 'package:fantom_games/resources/battleship/socket_methods.dart';
import 'package:fantom_games/reusable_widget/widget/loading_page_reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';

class LoadingBattleShip  extends StatefulWidget {
  const LoadingBattleShip ({super.key});

  @override
  State<LoadingBattleShip > createState() => _LoadingStateBattleShip ();
}

class _LoadingStateBattleShip  extends State<LoadingBattleShip > {
  final SocketMethodsBattleShip _socketMethods = SocketMethodsBattleShip();
  late AccountGlobal user;


  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);
    _socketMethods.createRoom(user.pseudo);

  }

  @override
  Widget build(BuildContext context) {
    return const LoadingPageReusable();
  }
}
