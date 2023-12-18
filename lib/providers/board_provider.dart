import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_2048/providers/score_provider.dart';

import 'package:my_2048/utilities/custom_logger.dart';
import 'package:my_2048/models/tile.dart';
import 'package:my_2048/utilities/move_resolver.dart';

enum MoveDirection { up, down, right, left }

class BoardProviderNotifier extends StateNotifier<List<Tile>> {
  BoardProviderNotifier(this._ref) : super([]) {
    initializeBoard();
  }

  final StateNotifierProviderRef _ref;

  final _log = CustomLogger('BoardProvider');
  final _random = Random();
  final _moveResolver = const MoveResolver();

  // Prepares a new board with 2 non-empty tiles
  void initializeBoard() {
    state = List.generate(
      16,
      (_) => Tile(
        value: 0,
        onMerge: (value) => _ref.read(scoreProvider.notifier).addScore(value),
      ),
    );
    _generateNewTile();
    _generateNewTile();

    _log.info('Board initialized');
  }

  void moveTiles(MoveDirection direction) {
    _log.trace('User swiped $direction');
    state = _moveResolver.move(boardState: state, swipeDirection: direction);
  }

  void _generateNewTile() {
    // 75% for 2 and 25% chance for 4
    final generatedValue = _random.nextDouble() < 0.75 ? 2 : 4;
    try {
      final tile = _randomEmptyTile;
      tile.value = generatedValue;

      // Notify listeners
      state = [...state];

      _log.trace(
          'Tile generated with index: ${state.indexOf(tile)} and value: $generatedValue');

      _checkGameOver();
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

  void _checkGameOver() {
    // TODO: Implement checkGameOver
  }
}

final boardProvider = StateNotifierProvider<BoardProviderNotifier, List<Tile>>(
    (ref) => BoardProviderNotifier(ref));
