import 'package:flutter/material.dart';

class ReusableSuccessNotification extends StatelessWidget {
  final bool isSuccessOpened;
  final Function() toggleSuccess;

  const ReusableSuccessNotification({super.key,
    required this.isSuccessOpened,
    required this.toggleSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.06,
      right: MediaQuery.of(context).size.width * 0,
      child: InkWell(
        onTap: toggleSuccess,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                isSuccessOpened ? Icons.cancel : Icons.emoji_events,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableSuccess extends StatefulWidget {
  const TableSuccess({super.key});

  @override
  TableSuccessState createState() => TableSuccessState();
}

class TableSuccessState extends State<TableSuccess> {
  bool isSuccessOpened = false;

  void toggleSuccess() {
    setState(() {
      isSuccessOpened = !isSuccessOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(

        children: [
            ReusableSuccessNotification(
                isSuccessOpened: isSuccessOpened,
                toggleSuccess: toggleSuccess,
            ),

            if (isSuccessOpened)
                Positioned(
                top: screenHeight * 0.33,
                right: 0,
                child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                    ),
                    borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    ),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.005, left: screenWidth * 0.002),
                        child: LayoutBuilder(
                        builder: (context, constraints) {
                            double iconSize = constraints.maxHeight * 0.1;
                            return Icon(
                            Icons.star,
                            color: Colors.black,
                            size: iconSize,
                            );
                        },
                        ),
                    ),
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            LayoutBuilder(
                            builder: (context, constraints) {
                                double fontsize = constraints.maxHeight * 0.1;
                                return Text(
                                "Le succès",
                                style: TextStyle(
                                    fontSize: fontsize,
                                    color: Colors.black,
                                ),
                                );
                            },
                            ),
                        ],
                        ),
                    ),
                    Row(
                        children: [
                        LayoutBuilder(
                            builder: (context, constraints) {
                            double fontSize = constraints.maxHeight * 0.1;
                            double iconSize = constraints.maxHeight * 0.1;
                            return Row(
                                children: [
                                Text(
                                    "1",
                                    style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black,
                                    ),
                                ),
                                Image.asset(
                                    "assets/FantomGamesIcon.png",
                                    height: iconSize,
                                    width: iconSize,
                                ),
                                ],
                            );
                            },
                        ),
                        ],
                    ),
                    ],
                ),
                ),
            ),
      ],
    );
  }
}