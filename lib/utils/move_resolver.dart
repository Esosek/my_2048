import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/board_provider.dart';

class MoveResolver {
  MoveResolver({
    required this.onMerge,
    required this.board,
  });

  final void Function(int value) onMerge;
  final List<Tile> board;

  static const _columnCount = 4;
  static const _rowCount = 4;

  // Return new state after move was made
  List<Tile> move(MoveDirection swipeDirection) {
    switch (swipeDirection) {
      case MoveDirection.up:
        return _moveUp();
      case MoveDirection.right:
        return _moveRight();
      case MoveDirection.down:
        return _moveDown();
      case MoveDirection.left:
        return _moveLeft();
      default:
        throw Exception('Invalid swipe direction detected $swipeDirection');
    }
  }

  List<Tile> _moveUp() => _processBoard(board);
  List<Tile> _moveDown() {
    // Flip the board by 180 degrees
    List<Tile> rotatedBoard = board.reversed.toList();
    rotatedBoard = _processBoard(rotatedBoard);
    return rotatedBoard.reversed.toList(); // Rotate back
  }

  List<Tile> _moveLeft() {
    List<Tile> rotatedBoard = _rotateBoard90DegreesClockwise(board);
    rotatedBoard = _processBoard(rotatedBoard);
    return _rotateBoard90DegreesCounterClockwise(rotatedBoard);
  }

  List<Tile> _moveRight() {
    List<Tile> rotatedBoard = _rotateBoard90DegreesCounterClockwise(board);
    rotatedBoard = _processBoard(rotatedBoard);
    return _rotateBoard90DegreesClockwise(rotatedBoard);
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
          onMerge(originalTile.value);

          nonEmptyTiles[i] = Tile.merged(mergeToTile);
          nonEmptyTiles[i + 1] = Tile.empty(originalTile);
        }
      }

      nonEmptyTiles = nonEmptyTiles.where((tile) => !tile.isEmpty).toList();

      // Fill the rest of the column with empty tiles
      List<Tile> updatedColumn = [
        ...nonEmptyTiles,
        ...List.filled(4 - nonEmptyTiles.length, const Tile(value: 0)),
      ];

      updatedBoardState[col] = updatedColumn[0];
      updatedBoardState[col + 4] = updatedColumn[1];
      updatedBoardState[col + 8] = updatedColumn[2];
      updatedBoardState[col + 12] = updatedColumn[3];
    }
    return updatedBoardState;
  }

  List<Tile> _rotateBoard90DegreesClockwise(List<Tile> board) {
    List<Tile> rotatedBoard = List<Tile>.filled(16, const Tile(value: 0));

    for (int row = 0; row < _rowCount; row++) {
      for (int col = 0; col < _columnCount; col++) {
        rotatedBoard[col * _columnCount + (_columnCount - row - 1)] =
            board[row * _columnCount + col];
      }
    }
    return rotatedBoard;
  }

  List<Tile> _rotateBoard90DegreesCounterClockwise(List<Tile> board) {
    List<Tile> rotatedBoard = List<Tile>.filled(16, const Tile(value: 0));

    for (int row = 0; row < _rowCount; row++) {
      for (int col = 0; col < _columnCount; col++) {
        rotatedBoard[row * _columnCount + col] =
            board[col * _columnCount + (_columnCount - row - 1)];
      }
    }
    return rotatedBoard;
  }
}
