import 'package:fantom_games/reusable_widget/method/message_bar.dart';
import 'package:flutter/material.dart';

class BoatsAndColor{
  bool isBoatHere;
  Color colorOfTheBoat;
  BoatsAndColor(this.isBoatHere, this.colorOfTheBoat);
}


class Boats {
  List<dynamic> boat5 = [];
  List<dynamic> boat4 = [];
  List<dynamic> boat3 = [];
  List<dynamic> boat2 = [];
  List<dynamic> boat10 = [];
  List<dynamic> boat11 = [];
  bool isGameStarted = false;
  bool isBoat5Sink = false;
  bool isBoat4Sink = false;
  bool isBoat3Sink = false;
  bool isBoat2Sink = false;
  bool isBoat10Sink = false;
  bool isBoat11Sink = false;


  bool isEmpty(){
    if(boat5.isEmpty && boat4.isEmpty && boat3.isEmpty && boat2.isEmpty && boat10.isEmpty && boat11.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  void boatSinkMessage(BuildContext context){
    if(boat5.isEmpty && !isBoat5Sink){
      showMessageBar(
          context,'Un bâteau de taille 5 a été coulé !',
      );
      isBoat5Sink=true;
    }
    if(boat4.isEmpty && !isBoat4Sink){
      showMessageBar(
        context,'Un bâteau de taille 4 a été coulé !',
      );
      isBoat4Sink=true;
    }
    if(boat3.isEmpty && !isBoat3Sink){
      showMessageBar(
        context,'Un bâteau de taille 3 a été coulé !',
      );
      isBoat3Sink=true;
    }
    if(boat2.isEmpty && !isBoat2Sink){
      showMessageBar(
        context,'Un bâteau de taille 2 a été coulé !',
      );
      isBoat2Sink=true;
    }
    if(boat10.isEmpty && !isBoat10Sink){
      showMessageBar(
        context,'Un bâteau de taille 1 a été coulé !',
      );
      isBoat10Sink=true;
    }
    if(boat11.isEmpty && !isBoat11Sink){
      showMessageBar(
        context,'Un bâteau de taille 1 a été coulé !',
      );
      isBoat11Sink=true;
    }
  }

  void createBoats(List<dynamic> boatsData) {
    boat5 = boatsData[0];
    boat4 = boatsData[1];
    boat3 = boatsData[2];
    boat2 = boatsData[3];
    boat10 = boatsData[4];
    boat11 = boatsData[5];
  }

  void setBoats(Boats boats){
    boat5 = boats.boat5;
    boat4 = boats.boat4;
    boat3 = boats.boat3;
    boat2 = boats.boat2;
    boat10 = boats.boat10;
    boat11 = boats.boat11;
  }

  BoatsAndColor isBoatAtPosition(List<int> position) {
    BoatsAndColor result = BoatsAndColor(false, Colors.white);
    for(var coo1 in boat5){
      if (coo1[0] == position[0] && coo1[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.red;
      }
    }
    for(var coo2 in boat4){
      if (coo2[0] == position[0] && coo2[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.orange;
      }
    }
    for(var coo3 in boat3){
      if (coo3[0] == position[0] && coo3[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.purple;
      }
    }
    for(var coo4 in boat2){
      if (coo4[0] == position[0] && coo4[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.green;
      }
    }
    for(var coo5 in boat10){
      if (coo5[0] == position[0] && coo5[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.yellow;
      }
    }
    for(var coo6 in boat11){
      if (coo6[0] == position[0] && coo6[1] == position[1]) {
        result.isBoatHere=true;
        result.colorOfTheBoat=Colors.grey;
      }
    }
    return result;
  }
}