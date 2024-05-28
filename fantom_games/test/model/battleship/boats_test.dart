// Import the test package and your Dart file.
import 'package:fantom_games/model/battleship/boats.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  group('Boats', () {
    test('isEmpty should return true when all boats are empty', () {
      final boats = Boats();
      expect(boats.isEmpty(), isTrue);
    });

    test('isEmpty should return false when at least one boat is not empty', () {
      final boats = Boats();
      boats.boat5 = [[0, 0]];
      expect(boats.isEmpty(), isFalse);
    });

    test('createBoats should correctly assign boat data', () {
      final boats = Boats();
      final boatsData = [
        [[0, 0]],
        [[1, 1]],
        [[2, 2]],
        [[3, 3]],
        [[4, 4]],
        [[5, 5]]
      ];
      boats.createBoats(boatsData);
      expect(boats.boat5, equals([[0, 0]]));
      expect(boats.boat4, equals([[1, 1]]));
      expect(boats.boat3, equals([[2, 2]]));
      expect(boats.boat2, equals([[3, 3]]));
      expect(boats.boat10, equals([[4, 4]]));
      expect(boats.boat11, equals([[5, 5]]));
    });

    test('setBoats should correctly copy boat data from another instance', () {
      final boats1 = Boats();
      final boats2 = Boats();
      boats1.boat5 = [[0, 0]];
      boats1.boat4 = [[1, 1]];
      boats1.boat3 = [[2, 2]];
      boats1.boat2 = [[3, 3]];
      boats1.boat10 = [[4, 4]];
      boats1.boat11 = [[5, 5]];
      boats2.setBoats(boats1);
      expect(boats2.boat5, equals([[0, 0]]));
      expect(boats2.boat4, equals([[1, 1]]));
      expect(boats2.boat3, equals([[2, 2]]));
      expect(boats2.boat2, equals([[3, 3]]));
      expect(boats2.boat10, equals([[4, 4]]));
      expect(boats2.boat11, equals([[5, 5]]));
    });

    test('isBoatAtPosition should correctly identify boats and colors', () {
      final boats = Boats();
      boats.createBoats([
        [[0, 0]],  // boat5
        [[1, 1]],  // boat4
        [[2, 2]],  // boat3
        [[3, 3]],  // boat2
        [[4, 4]],  // boat10
        [[5, 5]]   // boat11
      ]);

      expect(boats.isBoatAtPosition([0, 0]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([0, 0]).colorOfTheBoat, equals(Colors.red));

      expect(boats.isBoatAtPosition([1, 1]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([1, 1]).colorOfTheBoat, equals(Colors.orange));

      expect(boats.isBoatAtPosition([2, 2]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([2, 2]).colorOfTheBoat, equals(Colors.purple));

      expect(boats.isBoatAtPosition([3, 3]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([3, 3]).colorOfTheBoat, equals(Colors.green));

      expect(boats.isBoatAtPosition([4, 4]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([4, 4]).colorOfTheBoat, equals(Colors.yellow));

      expect(boats.isBoatAtPosition([5, 5]).isBoatHere, isTrue);
      expect(boats.isBoatAtPosition([5, 5]).colorOfTheBoat, equals(Colors.grey));

      expect(boats.isBoatAtPosition([6, 6]).isBoatHere, isFalse);
      expect(boats.isBoatAtPosition([6, 6]).colorOfTheBoat, equals(Colors.white));
    });
  });
}
