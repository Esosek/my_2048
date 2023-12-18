import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/score_provider.dart';

void main() {
  ProviderContainer setProvider() {
    final container = ProviderContainer();
    addTearDown(() => container.dispose());
    return container;
  }

  group('Tile', () {
    test('should create a Tile with a given value', () {
      const value = 2;
      final tile = Tile(value: value, onMerge: (_) {});

      expect(tile.value, value);
    });

    test('should return the correct value', () {
      final tile = Tile(value: 2, onMerge: (_) {});

      expect(tile.value, equals(2));
    });

    test('should allow updating the value', () {
      final tile = Tile(value: 2, onMerge: (_) => {});
      const newValue = 4;
      tile.value = newValue;

      expect(tile.value, equals(newValue));
    });

    test('isEmpty returns true for a tile with value 0', () {
      final tile = Tile(value: 0, onMerge: (_) {});

      expect(tile.isEmpty, equals(true));
    });

    test('isEmpty returns false for a tile with a non-zero value', () {
      final tile = Tile(value: 2, onMerge: (_) {});

      expect(tile.isEmpty, equals(false));
    });

    test('''mergeTo correctly increments the value of provided tile
     and sets the original tile value to 0''', () {
      final originalTile = Tile(value: 2, onMerge: (_) {});
      final mergeTotile = Tile(value: 2, onMerge: (_) {});

      originalTile.mergeTo(mergeTotile);

      expect(originalTile.isEmpty, equals(true));
      expect(mergeTotile.value, equals(4));
    });

    test(
        'mergeTo correctly prevents any changes if the tiles values are different',
        () {
      final originalTile = Tile(value: 2, onMerge: (_) {});
      final mergeTotile = Tile(value: 4, onMerge: (_) {});

      originalTile.mergeTo(mergeTotile);

      expect(originalTile.value, equals(2));
      expect(mergeTotile.value, equals(4));
    });

    test('mergeTo correctly increments score by the value of original tile',
        () {
      final providerContainer = setProvider();
      final originalTile = Tile(
        value: 2,
        onMerge: (value) =>
            providerContainer.read(scoreProvider.notifier).addScore(value),
      );
      final mergeTotile = Tile(value: 2, onMerge: (_) {});

      originalTile.mergeTo(mergeTotile);

      expect(providerContainer.read(scoreProvider)[Score.current], equals(2));
    });
  });
}
