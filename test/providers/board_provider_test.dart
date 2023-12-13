import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/providers/board_provider.dart';

void main() {
  group('BoardProvider', () {
    test('board is generated with two tiles, each with value 2 or 4', () {
      final container = ProviderContainer();
      addTearDown(() => container.dispose());

      container.read(boardProvider.notifier).initializeBoard();
      final board = container.read(boardProvider);
      final nonEmptyTiles = board.where((tile) => tile.value != 0);

      expect(board, isNotEmpty);
      expect(nonEmptyTiles.length, 2);

      for (var tile in nonEmptyTiles) {
        expect(tile.value, anyOf(2, 4));
      }
    });
  });
}
