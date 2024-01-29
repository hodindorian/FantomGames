import 'package:fantom_games/model/account.dart';
import 'package:flutter/material.dart';

class AccountGlobal extends ChangeNotifier {
  Account _account = Account("tmp@mail.com", "tmp", "tmp", "tmp", "000",0,0,"");
  Account get account => _account;

  void updateAccount(String email, String pseudo, String ?lastname, String ?firstname, String ?phoneNumber, int gameLevel, double cryptoBalance, String ?image) {
    _account = Account(email, pseudo, lastname, firstname, phoneNumber, gameLevel,cryptoBalance, image);
    notifyListeners();
  }

  set pseudo(String newPseudo) {
    _account.pseudo = newPseudo;
  }

  set lastname(String? newLastname) {
    _account.lastname = newLastname;
  }

  set firstname(String? newFirstname) {
    _account.firstname = newFirstname;
  }

  set phoneNumber(String? newPhoneNumber) {
    _account.phoneNumber = newPhoneNumber;
  }

  set image(String? newImage){
    _account.image = newImage;
  }

  String get email => _account.email;
  String get pseudo => _account.pseudo;
  String? get lastname => _account.lastname;
  String? get firstname => _account.firstname;
  String? get phoneNumber => _account.phoneNumber;
  int get gameLevel => _account.gameLevel;
  double get cryptoBalance => _account.cryptoBalance;
  String? get image => _account.image;
  List<String> get transactionHistory => _account.transactionHistory;

  void displayInfoUser(){
    _account.displayAccountInfo();
  }
}