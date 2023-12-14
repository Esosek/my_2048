import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Tile {
  Tile(this.value) : id = const Uuid().v4();

  final String id;
  int value;

  Color get color {
    switch (value) {
      case 2:
        return const Color.fromARGB(255, 238, 227, 218);
      case 4:
        return const Color.fromARGB(255, 238, 227, 218);
      case 8:
        return const Color.fromARGB(255, 238, 227, 218);
      case 16:
        return const Color.fromARGB(255, 238, 227, 218);
      case 32:
        return const Color.fromARGB(255, 238, 227, 218);
      default:
        return const Color.fromARGB(255, 213, 205, 196);
    }
  }
}
