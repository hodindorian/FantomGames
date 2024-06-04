import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../reusable_widget/widget/lobby_page_reusable.dart';

class LobbyBattleShip  extends StatefulWidget {
  const LobbyBattleShip ({super.key, required this.roomID});
  final String roomID;

  @override
  State<LobbyBattleShip > createState() => _LobbyStateBattleShip ();
}

class _LobbyStateBattleShip extends State<LobbyBattleShip > with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late TextEditingController roomIdController;
  late String roomId1;
  late String roomId2;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(text: Provider.of<RoomGlobalBattleShip>(context, listen: false).roomData['id']);
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

