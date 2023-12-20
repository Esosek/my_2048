import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/board_provider.dart';

void main() {
  ProviderContainer getMockProviderContainer(List<Tile> initialValues) {
    final container = ProviderContainer(
      overrides: [
        boardProvider.overrideWith(
          (ref) => BoardProviderNotifier.withValue(
              ref: ref, initialValue: initialValues),
        ),
      ],
    );
    addTearDown(() => container.dispose());
    return container;
  }

  group('BoardNotifier', () {
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

    test('''state is correctly updated
     when move in provided direction changed board''', () {
      final providerContainer = getMockProviderContainer(
        List.filled(16, Tile(value: 2)),
      );

      providerContainer
          .read(boardProvider.notifier)
          .moveTiles(MoveDirection.up);

      final newBoardState = providerContainer.read(boardProvider);
      for (var i = 0; i < newBoardState.length; i++) {
        final tileValue = newBoardState[i].value;
        if (i < 8) {
          expect(tileValue, equals(4));
        }
      }
    });

    test('''state is not updated
     when move in provided direction did not change board''', () {
      final mockBoardState = List.generate(16, (index) => Tile(value: index));
      final providerContainer = getMockProviderContainer(mockBoardState);

      providerContainer
          .read(boardProvider.notifier)
          .moveTiles(MoveDirection.right);

      final newBoardState = providerContainer.read(boardProvider);

      for (var i = 0; i < newBoardState.length; i++) {
        expect(newBoardState[i].value, equals(mockBoardState[i].value));
      }
    });
  });
}
