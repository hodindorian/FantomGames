class Account {
  String _email;
  String _pseudo;
  String ?_lastname;
  String ?_firstname;
  String ?_phoneNumber;
  double _cryptoBalance; 
  int _gameLevel;
  List<String> _transactionHistory; 

  Account(this._email, this._pseudo, this._lastname, this._firstname, this._phoneNumber, this._gameLevel, this._cryptoBalance,{List<String>? transactionHistory}) :
    _transactionHistory = transactionHistory ?? [];
  

  String get email => _email;
  String get pseudo => _pseudo;
  String? get lastname => _lastname;
  String? get firstname => _firstname;
  String? get phoneNumber => _phoneNumber;
  int get gameLevel => _gameLevel;
  double get cryptoBalance => _cryptoBalance;
  List<String> get transactionHistory => _transactionHistory;

  /*
  set email(String newEmail){
    _email = newEmail;
  }
  */

  set pseudo(String newPseudo) {
    _pseudo = newPseudo;
  }

  set lastname(String? newLastname) {
    _lastname = newLastname;
  }

  set firstname(String? newFirstname) {
    _firstname = newFirstname;
  }

  set phoneNumber(String? newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
  }

  /*
  set gameLevel(int newGameLevel) {
    _gameLevel = newGameLevel;
  }

  set cryptoBalance(double newCryptoBalance){
    _cryptoBalance=newCryptoBalance;
  }
  */

  // Méthode pour afficher les informations du compte
  void displayAccountInfo() {
    print('Email: $_email');
    print('Pseudo: $_pseudo');
    print('Nom: $_lastname');
    print('Prénom: $_firstname');
    print('Numéro de téléphone: $_phoneNumber');
    print('Solde de crypto-monnaie: $_cryptoBalance');
    print('Niveau de jeu: $_gameLevel');
    print('Historique des transactions: $_transactionHistory');
  }
}

