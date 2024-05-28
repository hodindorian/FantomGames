import 'package:fantom_games/model/global_object.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GlobalObject tests', () {
    test('Initial values', () {
      final globalObject = GlobalObject();

      expect(globalObject.stayConnected, false);
      expect(globalObject.alreadyConnected, false);
    });

    test('Setting stayConnected', () {
      final globalObject = GlobalObject();

      globalObject.stayConnected = true;

      expect(globalObject.stayConnected, true);
    });

    test('Setting alreadyConnected', () {
      final globalObject = GlobalObject();

      globalObject.alreadyConnected = true;

      expect(globalObject.alreadyConnected, true);
    });
  });
}
