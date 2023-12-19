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
  static const _rowCount = 4;

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
    // Flip the board by 180 degrees
    List<Tile> rotatedBoard = board.reversed.toList();
    rotatedBoard = _processBoard(rotatedBoard);
    return rotatedBoard.reversed.toList(); // Rotate back
  }

  List<Tile> moveLeft() {
    List<Tile> rotatedBoard = rotateBoard90DegreesClockwise(board);
    rotatedBoard = _processBoard(rotatedBoard);
    return rotateBoard90DegreesCounterClockwise(rotatedBoard);
  }

  List<Tile> moveRight() {
    List<Tile> rotatedBoard = rotateBoard90DegreesCounterClockwise(board);
    rotatedBoard = _processBoard(rotatedBoard);
    return rotateBoard90DegreesClockwise(rotatedBoard);
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

      for (int i = 0; i < nonEmptyTiles.length - 1; i++) {
        final originalTile = nonEmptyTiles[i + 1];
        final mergeToTile = nonEmptyTiles[i];

        // Merge if values are equal
        if (originalTile.value == mergeToTile.value) {
          stateNotifierProviderRef
              .read(scoreProvider.notifier)
              .addScore(originalTile.value);

          nonEmptyTiles[i] = Tile.merged(mergeToTile);
          nonEmptyTiles[i + 1] = Tile.empty(originalTile);
        }
      }

      nonEmptyTiles = nonEmptyTiles.where((tile) => !tile.isEmpty).toList();

      // Fill the rest of the column with empty tiles
      List<Tile> updatedColumn = [
        ...nonEmptyTiles,
        ...List.generate(
          4 - nonEmptyTiles.length,
          (index) => Tile(value: 0),
        ),
      ];

      updatedBoardState[col] = updatedColumn[0];
      updatedBoardState[col + 4] = updatedColumn[1];
      updatedBoardState[col + 8] = updatedColumn[2];
      updatedBoardState[col + 12] = updatedColumn[3];
    }
    return updatedBoardState;
  }

  List<Tile> rotateBoard90DegreesClockwise(List<Tile> board) {
    List<Tile> rotatedBoard = List<Tile>.filled(16, Tile(value: 0));

    for (int row = 0; row < _rowCount; row++) {
      for (int col = 0; col < _columnCount; col++) {
        rotatedBoard[col * _columnCount + (_columnCount - row - 1)] =
            board[row * _columnCount + col];
      }
    }
    return rotatedBoard;
  }

  List<Tile> rotateBoard90DegreesCounterClockwise(List<Tile> board) {
    List<Tile> rotatedBoard = List<Tile>.filled(16, Tile(value: 0));

    for (int row = 0; row < _rowCount; row++) {
      for (int col = 0; col < _columnCount; col++) {
        rotatedBoard[row * _columnCount + col] =
            board[col * _columnCount + (_columnCount - row - 1)];
      }
    }
    return rotatedBoard;
  }
}
