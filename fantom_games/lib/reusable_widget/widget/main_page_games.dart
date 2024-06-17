import 'package:flutter/material.dart';

List<Widget> generatePositionedWidgets(int numberOfWidgets,List<String> imagesPath,List<Widget> nextPages,List<String> texts,BuildContext context) {
  List<Widget> widgets = [];
  for (int i = 0; i < numberOfWidgets; i++) {
    double leftPosition = MediaQuery.of(context).size.width * 0.3 + i * MediaQuery.of(context).size.width * 0.3;
    widgets.add(
      Positioned(
        top: MediaQuery.of(context).size.height * 0.60,
        left: leftPosition,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPages[i]),
            );
          },
          child: Column(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.08,
                height: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height)  * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.black, width: 2.0),
                  image: DecorationImage(
                    image: AssetImage(imagesPath[i]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                texts[i],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return widgets;
}