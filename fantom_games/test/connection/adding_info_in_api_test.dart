import 'dart:convert';

import 'package:fantom_games/connection/adding_info_in_api.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

// Unit tests
void main() {
  test('Test gettingInfo with valid response', () async {
    final response = Response(
        jsonEncode([
          {
            'pseudo': 'test',
            'email': 'test@example.com',
            'lastname': 'Doe',
            'firstname': 'John',
            'phoneNumber': '1234567890',
            'gameLevel': '1',
            'cryptoBalance': '1000',
          }
        ]),
        200);
    final result = await gettingInfo(response, 'test');
    expect(result[0], true);
    expect(result[1], 'test@example.com');
  });

  test('Test addingInfo with valid URI and JSON', () async {
    final uri = Uri.https('apiuser.fantomgames.eu', '/changePhone');
    final response = await addingInfo(
        uri, jsonEncode({'pseudo': 'test', 'phone': '1234567890'}));
    expect(response.statusCode, 200);
  });
}