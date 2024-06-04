import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:fantom_games/reusable_widget/widget/lobby_page_reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LobbyTicTacToe extends StatefulWidget {
  const LobbyTicTacToe({super.key, required this.roomID});
  final String roomID;

  @override
  State<LobbyTicTacToe> createState() => _LobbyStateTicTacToe();
}

class _LobbyStateTicTacToe extends State<LobbyTicTacToe> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late TextEditingController roomIdController;
  late String roomId1;
  late String roomId2;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(text: Provider.of<RoomGlobalTicTacToe>(context, listen: false).roomData['id']);
    roomId1 = widget.roomID.substring(0, 4);
    roomId2 = widget.roomID.substring(4, 8);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LobbyPageReusable(animationController: _animationController, roomId1: roomId1, roomId2: roomId2);
  }
}

