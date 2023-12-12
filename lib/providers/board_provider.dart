import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/models/tile.dart';

class BoardProviderNotifier extends StateNotifier<List<Tile>> {
  BoardProviderNotifier() : super([]);
}

final boardProvider = StateNotifierProvider<BoardProviderNotifier, List<Tile>>(
    (ref) => BoardProviderNotifier());
