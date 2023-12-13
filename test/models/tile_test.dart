import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/models/tile.dart';

void main() {
  group('Tile', () {
    test('should create a Tile with a given value and a non-empty id', () {
      const value = 2;
      final tile = Tile(value);

      expect(tile.id, isNotEmpty);
      expect(tile.id, isA<String>());
      expect(tile.value, value);
    });

    test('should create unique ids for different tiles', () {
      final tile1 = Tile(2);
      final tile2 = Tile(2);

      expect(tile1.id, isNot(equals(tile2.id)));
    });

    test('should return the correct value', () {
      final tile = Tile(2);

      expect(tile.value, equals(2));
    });

    test('should allow updating the value', () {
      final tile = Tile(2);
      const newValue = 4;
      tile.value = newValue;

      expect(tile.value, equals(newValue));
    });
  });
}
