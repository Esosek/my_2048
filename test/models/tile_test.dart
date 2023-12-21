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
      const tile = Tile(value: value);

      expect(tile.value, value);
    });

    test('should return the correct value', () {
      const tile = Tile(value: 2);

      expect(tile.value, equals(2));
    });

    test('isEmpty returns true for a tile with value 0', () {
      const tile = Tile(value: 0);

      expect(tile.isEmpty, equals(true));
    });

    test('isEmpty returns false for a tile with a non-zero value', () {
      const tile = Tile(value: 2);

      expect(tile.isEmpty, equals(false));
    });

    test('''merging correctly increments the value of provided tile
     and sets the original tile value to 0''', () {
      Tile originalTile = const Tile(value: 2);
      Tile mergeTotile = const Tile(value: 2);

      mergeTotile = Tile.merged(mergeTotile);
      originalTile = Tile.empty(originalTile);

      expect(originalTile.isEmpty, equals(true));
      expect(mergeTotile.value, equals(4));
    });

    test(
        'merging correctly prevents any changes if the tiles values are different',
        () {
      const originalTile = Tile(value: 2);
      const mergeTotile = Tile(value: 4);

      Tile.merged(mergeTotile);
      const Tile.empty(originalTile);

      expect(originalTile.value, equals(2));
      expect(mergeTotile.value, equals(4));
    });

    test('merging correctly increments score by the value of original tile',
        () {
      final providerContainer = setProvider();
      Tile originalTile = const Tile(value: 2);
      Tile mergeTotile = const Tile(value: 2);

      providerContainer
          .read(scoreProvider.notifier)
          .addScore(originalTile.value);
      mergeTotile = Tile.merged(mergeTotile);
      originalTile = Tile.empty(originalTile);

      expect(providerContainer.read(scoreProvider)[Score.current], equals(2));
    });
  });
}
