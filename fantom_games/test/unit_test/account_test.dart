import 'package:flutter_test/flutter_test.dart';
import 'package:fantom_games/model/account.dart';

void main() {
  group('Account Tests', () {
    late Account account;

    setUp(() {
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
    });

    test('Update account values', () {
      account.pseudo = 'newjohndoe';
    });



  });
}
