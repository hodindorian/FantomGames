import 'package:flutter/foundation.dart';

class Account {
  final String _email;
  final String _pseudo;
  final String ?_lastname;
  final String ?_firstname;
  final String ?_phoneNumber;
  final String ?_cryptoAddress;
  final int _gameLevel;
  final Uint8List? _image;
  final List<String> _transactionHistory;

  Account(this._email, this._pseudo, this._lastname, this._firstname, this._phoneNumber, this._gameLevel, this._cryptoAddress, this._image,{List<String>? transactionHistory}) :
    _transactionHistory = transactionHistory ?? [];
  

  String get email => _email;
  String get pseudo => _pseudo;
  String? get lastname => _lastname;
  String? get firstname => _firstname;
  String? get phoneNumber => _phoneNumber;
  int get gameLevel => _gameLevel;
  String? get cryptoAddress => _cryptoAddress;
  Uint8List? get image => _image;
  List<String> get transactionHistory => _transactionHistory;

  /*
  set email(String newEmail){
    _email = newEmail;
  }
  */

  set pseudo(String newPseudo) {
    pseudo = newPseudo;
  }

  set lastname(String? newLastname) {
    lastname = newLastname;
  }

  set firstname(String? newFirstname) {
    firstname = newFirstname;
  }

  set phoneNumber(String? newPhoneNumber) {
    phoneNumber = newPhoneNumber;
  }

  set image(Uint8List? newImage) {
    image = newImage;
  }

  set cryptoAddress(String? newCryptoAddress) {
    cryptoAddress = newCryptoAddress;
  }

  set gameLevel(int newGameLevel) {
    gameLevel = newGameLevel;
  }


  void displayAccountInfo() {
    if (kDebugMode) {
      print('Email: $_email');
      print('Pseudo: $_pseudo');
      print('Nom: $_lastname');
      print('Prénom: $_firstname');
      print('Numéro de téléphone: $_phoneNumber');
      print('Adresse crypto : $_cryptoAddress');
      print('Niveau de jeu: $_gameLevel');
      print('Historique des transactions: $_transactionHistory');
    }

  }
}

