import 'package:my_2048/models/tile.dart';
import 'package:my_2048/providers/board_provider.dart';

class MoveResolver {
  const MoveResolver();

  // Return new state after move was made
  List<Tile> move({
    required List<Tile> boardState,
    required MoveDirection swipeDirection,
  }) {
    switch (swipeDirection) {
      case MoveDirection.up:
        return moveUp();
      case MoveDirection.right:
        return moveRight();
      case MoveDirection.down:
        return moveUp();
      case MoveDirection.left:
        return moveUp();
      default:
        throw Exception('Invalid swipe direction detected $swipeDirection');
    }
  }

  List<Tile> moveUp() {
    return [];
  }

  List<Tile> moveRight() {
    return [];
  }

  List<Tile> moveDown() {
    return [];
  }

  List<Tile> moveLeft() {
    return [];
  }
}
