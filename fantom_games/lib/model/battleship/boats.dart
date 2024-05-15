class Boats {
  List<dynamic> boat5 = [];
  List<dynamic> boat4 = [];
  List<dynamic> boat3 = [];
  List<dynamic> boat2 = [];
  List<dynamic> boat10 = [];
  List<dynamic> boat11 = [];

  bool isEmpty(){
    if(boat5.isEmpty || boat4.isEmpty || boat3.isEmpty || boat2.isEmpty || boat10.isEmpty || boat11.isEmpty){
      return true;
    }else{
      return false;
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
}