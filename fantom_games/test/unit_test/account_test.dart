import 'package:flutter_test/flutter_test.dart';
import 'package:fantom_games/src/model/account.dart'; // Remplacez par le chemin réel de votre classe Account

void main() {
  group('Account Tests', () {
    late Account account;

    setUp(() {
      // Initialisation commune avant chaque test
      account = Account(
        'johndoe@email.com',
        'johndoe123',
        'Doe',
        'John',
        '123-456-7890',
      );
    });

    test('Default account values', () {
      expect(account.email, 'johndoe@email.com');
      expect(account.pseudo, 'johndoe123');
      // Assurez-vous d'ajouter d'autres assertions pour les autres attributs.
    });

    test('Update accunt values', () {
      account.pseudo = 'newjohndoe';
      // Assurez-vous d'ajouter des assertions pour les valeurs mises à jour.
    });



  });
}
