import 'package:fantom_games/model/account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Account tests', () {
    test('Creating Account instance', () {
      final account = Account(
        'test@email.com',
        'testPseudo',
        'testLastname',
        'testFirstname',
        '123456789',
        1,
        "15151",
        Uint8List.fromList([0, 1, 2, 3]),
        transactionHistory: ['transaction1', 'transaction2'],
      );

      expect(account.email, 'test@email.com');
      expect(account.pseudo, 'testPseudo');
      expect(account.lastname, 'testLastname');
      expect(account.firstname, 'testFirstname');
      expect(account.phoneNumber, '123456789');
      expect(account.gameLevel, 1);
      expect(account.cryptoAddress, "15151");
      expect(account.image, Uint8List.fromList([0, 1, 2, 3]));
      expect(account.transactionHistory, ['transaction1', 'transaction2']);
    });

    test('Creating Account instance with default values', () {
      final account = Account(
        'test@email.com',
        'testPseudo',
        null,
        null,
        null,
        1,
        null,
        null,
      );

      expect(account.lastname, null);
      expect(account.firstname, null);
      expect(account.phoneNumber, null);
      expect(account.image, null);
      expect(account.cryptoAddress, null);
      expect(account.transactionHistory, []);
    });
  });
}
