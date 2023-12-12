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

    test('copyWith should create a Tile with the same id and updated value',
        () {
      const oldValue = 2;
      const newValue = 4;
      final originalTile = Tile(oldValue);
      final copiedTile = originalTile.copyWith(newValue);

      expect(copiedTile.id, originalTile.id);
      expect(copiedTile.value, newValue);
    });

    test(
        'copyWith should create a Tile with the same id and same value if null is provided',
        () {
      const oldValue = 2;
      final originalTile = Tile(oldValue);
      final copiedTile = originalTile.copyWith(null);

      expect(copiedTile.id, originalTile.id);
      expect(copiedTile.value, oldValue);
    });
  });
}
