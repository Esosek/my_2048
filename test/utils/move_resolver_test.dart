import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/board_provider.dart';
import 'package:my_2048/providers/score_provider.dart';
import 'package:my_2048/utils/move_resolver.dart';

void main() {
  List<Tile> setBoard(List<int> initialTileValues) {
    return List.generate(16, (index) => Tile(value: initialTileValues[index]));
  }

  group('MoveResolver', () {
    test('move up correctly updates the board state', () async {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 4, 0, 0],
            ...[0, 2, 4, 0],
            ...[0, 0, 2, 4],
            ...[4, 0, 0, 2],
          ]));

      final updatedBoardValues = moveResolver
          .move(MoveDirection.up)
          .map((tile) => tile.value)
          .toList();

      expect(
          updatedBoardValues,
          equals([
            ...[2, 4, 4, 4],
            ...[4, 2, 2, 2],
            ...[0, 0, 0, 0],
            ...[0, 0, 0, 0],
          ]));
    });
    test('move right correctly updates the board state', () async {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 4, 0, 0],
            ...[0, 2, 4, 0],
            ...[0, 0, 2, 4],
            ...[4, 0, 0, 2],
          ]));

      final updatedBoardValues = moveResolver
          .move(MoveDirection.right)
          .map((tile) => tile.value)
          .toList();

      expect(
          updatedBoardValues,
          equals([
            ...[0, 0, 2, 4],
            ...[0, 0, 2, 4],
            ...[0, 0, 2, 4],
            ...[0, 0, 4, 2],
          ]));
    });
    test('move down correctly updates the board state', () {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 4, 0, 0],
            ...[0, 2, 4, 0],
            ...[0, 0, 2, 4],
            ...[4, 0, 0, 2],
          ]));

      final updatedBoardValues = moveResolver
          .move(MoveDirection.down)
          .map((tile) => tile.value)
          .toList();

      expect(
          updatedBoardValues,
          equals([
            ...[0, 0, 0, 0],
            ...[0, 0, 0, 0],
            ...[2, 4, 4, 4],
            ...[4, 2, 2, 2],
          ]));
    });
    test('move left correctly updates the board state', () {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 4, 0, 0],
            ...[0, 2, 4, 0],
            ...[0, 0, 2, 4],
            ...[4, 0, 0, 2],
          ]));

      final updatedBoardValues = moveResolver
          .move(MoveDirection.left)
          .map((tile) => tile.value)
          .toList();

      expect(
          updatedBoardValues,
          equals([
            ...[2, 4, 0, 0],
            ...[2, 4, 0, 0],
            ...[2, 4, 0, 0],
            ...[4, 2, 0, 0],
          ]));
    });
    test('tiles merge correctly when moved', () {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 4, 8, 0],
            ...[2, 4, 8, 0],
            ...[2, 4, 0, 0],
            ...[2, 0, 0, 0],
          ]));

      final updatedBoardValues = moveResolver
          .move(MoveDirection.up)
          .map((tile) => tile.value)
          .toList();

      expect(
          updatedBoardValues,
          equals([
            ...[4, 8, 16, 0],
            ...[4, 4, 0, 0],
            ...[0, 0, 0, 0],
            ...[0, 0, 0, 0],
          ]));
    });

    test('''correctly returns same board
     when move in provided direction is not possible''', () {
      final moveResolver = MoveResolver(
          onMerge: (_) {},
          board: setBoard([
            ...[2, 2, 8, 0],
            ...[0, 4, 0, 0],
            ...[0, 2, 0, 0],
            ...[0, 0, 0, 0],
          ]));

      final boardAfterMove = moveResolver
          .move(MoveDirection.up)
          .map((tile) => tile.value)
          .toList();

      expect(
          boardAfterMove,
          equals([
            ...[2, 2, 8, 0],
            ...[0, 4, 0, 0],
            ...[0, 2, 0, 0],
            ...[0, 0, 0, 0],
          ]));
    });

    test('score updates correctly when tiles move', () {
      final providerContainer = ProviderContainer();
      addTearDown(() => providerContainer.dispose());

      final moveResolver = MoveResolver(
          onMerge: (value) {
            providerContainer.read(scoreProvider.notifier).addScore(value);
          },
          board: setBoard([
            ...[2, 4, 8, 0],
            ...[2, 4, 8, 0],
            ...[2, 4, 0, 0],
            ...[2, 0, 0, 0],
          ]));

      expect(providerContainer.read(scoreProvider)[Score.current], equals(0));

      moveResolver.move(MoveDirection.up);

      expect(providerContainer.read(scoreProvider)[Score.current], equals(16));
    });
  });
}
