import 'package:uuid/uuid.dart';

class Tile {
  Tile(this.value) : id = const Uuid().v4();

  Tile._copy(this.id, this.value);

  Tile copyWith(int? value) {
    return Tile._copy(
      id,
      value ?? this.value,
    );
  }

  final String id;
  final int value;
}
