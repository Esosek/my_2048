import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_2048/providers/game_state_provider.dart';
import 'package:my_2048/providers/moves_provider.dart';

import 'package:my_2048/utilities/custom_logger.dart';
import 'package:my_2048/models/tile.dart';
import 'package:my_2048/utilities/move_resolver.dart';

enum MoveDirection { up, down, right, left }

class BoardProviderNotifier extends StateNotifier<List<Tile>> {
  BoardProviderNotifier(this.ref) : super([]) {
    initializeBoard();
  }

  // For unit test
  BoardProviderNotifier.withValue(
      {required this.ref, required List<Tile> initialValue})
      : super(initialValue);

  final StateNotifierProviderRef ref;

  final _log = CustomLogger('BoardProvider');
  final _random = Random();

  // Prepares a new board with 2 non-empty tiles
  void initializeBoard() {
    state = List.filled(16, Tile(value: 0));

    _generateNewTile();
    _generateNewTile();

    _log.info('Board initialized');
  }

  void moveTiles(MoveDirection direction) {
    _log.trace('User swiped $direction');

    final moveResolver = MoveResolver(
      stateNotifierProviderRef: ref,
      board: state,
    );

    final boardAfterMove = moveResolver.move(direction);

    // Move successful
    if (_didBoardChange(boardAfterMove)) {
      _log.trace('Board did change');
      state = boardAfterMove;
      ref.read(movesProvider.notifier).addMove();
      _generateNewTile();
    }

    if (!_isMoveAvailable()) {
      ref.read(gameStateProvider.notifier).endGame();
    }
  }

  void _generateNewTile() {
    // 75% for 2 and 25% chance for 4
    final generatedValue = _random.nextDouble() < 0.75 ? 2 : 4;
    try {
      final emptyTileIndex = _randomEmptyTileIndex;
      final newState = List<Tile>.from(state);
      newState[emptyTileIndex] = Tile(value: generatedValue);

      state = newState;

      _log.trace(
          'New tile generated with index: $emptyTileIndex and value: $generatedValue');
    } catch (error) {
      _log.error(error.toString());
    }
  }

  int get _randomEmptyTileIndex {
    final emptyTileIndices = List<int>.generate(state.length, (index) => index)
        .where((index) => state[index].isEmpty)
        .toList();

    if (emptyTileIndices.isEmpty) {
      throw Exception('Could not find an empty tile');
    }

    return emptyTileIndices[_random.nextInt(emptyTileIndices.length)];
  }

  bool _didBoardChange(List<Tile> newBoard) {
    for (var i = 0; i < newBoard.length; i++) {
      if (newBoard[i].value != state[i].value) {
        return true;
      }
    }
    return false;
  }

  bool _isMoveAvailable() {
    final moveResolver = MoveResolver(
      stateNotifierProviderRef: ref,
      board: state,
      willUpdateScore: false,
    );

    for (var direction in MoveDirection.values) {
      final newBoard = moveResolver.move(direction);
      if (_didBoardChange(newBoard)) {
        _log.trace('Moves still available');
        return true;
      }
    }
    _log.trace('No more available moves');
    return false;
  }
}

final boardProvider = StateNotifierProvider<BoardProviderNotifier, List<Tile>>(
    (ref) => BoardProviderNotifier(ref));
