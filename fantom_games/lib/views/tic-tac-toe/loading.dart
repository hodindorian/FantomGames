import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';
import '../../resources/tic-tac-toe/socket_methods.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final SocketMethods _socketMethods = SocketMethods();
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
    return Container(
      color: Colors.blue,
      child : const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Veuillez patientez...",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
