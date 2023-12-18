import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/board_provider.dart';
import 'package:my_2048/providers/score_provider.dart';

class MoveResolver {
  MoveResolver({
    required this.stateNotifierProviderRef,
    required this.board,
    required this.swipeDirection,
  });

  final StateNotifierProviderRef stateNotifierProviderRef;
  final List<Tile> board;
  final MoveDirection swipeDirection;

  static const _columnCount = 4;

  // Return new state after move was made
  List<Tile> move() {
    switch (swipeDirection) {
      case MoveDirection.up:
        return moveUp();
      case MoveDirection.right:
        return moveRight();
      case MoveDirection.down:
        return moveDown();
      case MoveDirection.left:
        return moveLeft();
      default:
        throw Exception('Invalid swipe direction detected $swipeDirection');
    }
  }

  List<Tile> moveUp() => _processBoard(board);
  List<Tile> moveDown() {
    List<Tile> rotatedBoard = board.reversed.toList();
    rotatedBoard = _processBoard(rotatedBoard);
    // Rotate back
    return rotatedBoard.reversed.toList();
  }

  List<Tile> moveRight() {
    List<Tile> rotatedBoard = List.generate(
      16,
      (_) => Tile(
        value: 0,
        onMerge: (_) {},
      ),
    );

    // TODO: Rotate the board clockwise
    // TODO: moveUp()
    // TODO: Rotate the board back
    return [];
  }

  List<Tile> moveLeft() {
    return [];
  }

  List<Tile> _processBoard(List<Tile> boardState) {
    List<Tile> updatedBoardState = [...boardState];

    // Loop each column
    for (var col = 0; col < _columnCount; col++) {
      List<Tile> column = [
        boardState[col],
        boardState[col + 4],
        boardState[col + 8],
        boardState[col + 12],
      ];

      List<Tile> nonEmptyTiles = column.where((tile) => !tile.isEmpty).toList();

      // Merge if possible
      for (int i = 0; i < nonEmptyTiles.length - 1; i++) {
        if (nonEmptyTiles[i].value == nonEmptyTiles[i + 1].value) {
          nonEmptyTiles[i + 1].mergeTo(nonEmptyTiles[i]);
        }
      }

      nonEmptyTiles = nonEmptyTiles.where((tile) => !tile.isEmpty).toList();

      // Fill the rest of the column with empty tiles
      List<Tile> updatedColumn = [
        ...nonEmptyTiles,
        ...List.generate(
          4 - nonEmptyTiles.length,
          (_) => Tile(
            value: 0,
            onMerge: (value) => stateNotifierProviderRef
                .read(scoreProvider.notifier)
                .addScore(value),
          ),
        ),
      ];

      updatedBoardState[col] = updatedColumn[0];
      updatedBoardState[col + 4] = updatedColumn[1];
      updatedBoardState[col + 8] = updatedColumn[2];
      updatedBoardState[col + 12] = updatedColumn[3];
    }
    return updatedBoardState;
  }
}
