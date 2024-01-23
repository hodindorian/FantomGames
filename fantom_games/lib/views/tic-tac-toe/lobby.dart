import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key, required this.roomID});
  final String roomID;

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  late TextEditingController roomIdController;
  late String roomId1;
  late String roomId2;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(text: Provider.of<RoomGlobal>(context, listen: false).roomData['id']);
    roomId1 = widget.roomID.substring(0, 4);
    roomId2 = widget.roomID.substring(4, 8);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SelectableText(
            "En attente d'un joueur...",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          SelectableText(
            "Votre numéro de room est : $roomId1-$roomId2 ",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}

