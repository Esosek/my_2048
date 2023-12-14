import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Tile {
  Tile(this.value) : id = const Uuid().v4();

  final String id;
  int value;

  Color get backgroundColor {
    switch (value) {
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
        return const Color.fromARGB(255, 213, 205, 196);
    }
  }
}
