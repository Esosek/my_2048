import 'package:uuid/uuid.dart';

class Tile {
  Tile(this.value) : id = const Uuid().v4();

  final String id;
  int value;
}
