import 'dart:typed_data';
import 'package:fantom_games/model/global_account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountGlobal tests', () {
    test('Updating account', () {
      final accountGlobal = AccountGlobal();

      accountGlobal.updateAccount(
        'test@email.com',
        'testPseudo',
        'testLastname',
        'testFirstname',
        '123456789',
        1,
        100.0,
        Uint8List.fromList([0, 1, 2, 3]),
      );

      expect(accountGlobal.email, 'test@email.com');
      expect(accountGlobal.pseudo, 'testPseudo');
      expect(accountGlobal.lastname, 'testLastname');
      expect(accountGlobal.firstname, 'testFirstname');
      expect(accountGlobal.phoneNumber, '123456789');
      expect(accountGlobal.gameLevel, 1);
      expect(accountGlobal.cryptoBalance, 100.0);
      expect(accountGlobal.image, Uint8List.fromList([0, 1, 2, 3]));
    });
  });
}
