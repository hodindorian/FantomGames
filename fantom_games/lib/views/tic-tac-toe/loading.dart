import 'package:fantom_games/reusable_widget/widget/loading_page_reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_methods.dart';

class LoadingTicTacToe extends StatefulWidget {
  const LoadingTicTacToe({super.key});

  @override
  State<LoadingTicTacToe> createState() => _LoadingStateTicTacToe();
}

class _LoadingStateTicTacToe extends State<LoadingTicTacToe> {
  final SocketMethodsTicTacToe _socketMethods = SocketMethodsTicTacToe();
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
