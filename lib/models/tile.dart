import 'package:flutter/material.dart';

class Tile {
  const Tile({
    required this.value,
    this.originalBoardIndex,
    this.newBoardIndex,
  });

  Tile.merged(
    Tile tile, {
    this.originalBoardIndex,
  })  : value = tile.value * 2,
        newBoardIndex = tile.originalBoardIndex;

  const Tile.empty(Tile tile)
      : value = 0,
        originalBoardIndex = null,
        newBoardIndex = null;

  final int value;
  final int? originalBoardIndex;
  final int? newBoardIndex;

  bool get isEmpty => value == 0;

  Color get backgroundColor {
    switch (value) {
      case 0:
        return const Color.fromARGB(255, 213, 205, 196);
      case 2:
        return const Color.fromARGB(255, 238, 227, 218);
      case 4:
        return const Color.fromARGB(255, 237, 223, 200);
      case 8:
        return const Color.fromARGB(255, 242, 177, 120);
      case 16:
        return const Color.fromARGB(255, 245, 149, 98);
      case 32:
        return const Color.fromARGB(255, 245, 124, 95);
      case 64:
        return const Color.fromARGB(255, 246, 94, 58);
      case 128:
        return const Color.fromARGB(255, 237, 207, 115);
      case 256:
        return const Color.fromARGB(255, 237, 204, 97);
      case 512:
        return const Color.fromARGB(255, 237, 199, 80);
      case 1024:
        return const Color.fromARGB(255, 237, 197, 62);
      case 2048:
        return const Color.fromARGB(255, 237, 194, 45);
      default:
        // Dark color for values above 2048
        return const Color.fromARGB(255, 60, 58, 50);
    }
  }
}
