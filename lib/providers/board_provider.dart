import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/utilities/custom_logger.dart';
import 'package:my_2048/models/tile.dart';

enum MoveDirection { up, down, right, left }

class BoardProviderNotifier extends StateNotifier<List<Tile>> {
  BoardProviderNotifier() : super([]);

  final _log = CustomLogger('BoardProvider');
  final _random = Random();

  // Prepares a new board with 2 non-empty tiles
  void initializeBoard() {
    state = List.generate(16, (_) => Tile(0));
    _generateNewTile();
    _generateNewTile();

    _log.info('Board initialized');
  }

  void _generateNewTile() {
    // 75% for 2 and 25% chance for 4
    final generatedValue = _random.nextDouble() < 0.75 ? 2 : 4;
    try {
      final tile = _randomEmptyTile;
      tile.value = generatedValue;

      _log.trace(
          'Tile generated with index: ${state.indexOf(tile)} and value: $generatedValue');
    } catch (error) {
      _log.error(error.toString());
    }
  }

  Tile get _randomEmptyTile {
    final emptyTiles = state.where((tile) => tile.value == 0).toList();

    if (emptyTiles.isEmpty) {
      throw Exception('Could not find an empty tile');
    }

    final index = _random.nextInt(emptyTiles.length);
    return emptyTiles[index];
  }
}

final boardProvider = StateNotifierProvider<BoardProviderNotifier, List<Tile>>(
    (ref) => BoardProviderNotifier());
