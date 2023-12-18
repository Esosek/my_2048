import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/providers/board_provider.dart';
import 'package:my_2048/providers/moves_provider.dart';
import 'package:my_2048/providers/score_provider.dart';
import 'package:my_2048/utilities/custom_logger.dart';

enum GameState { active, ended }

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(this._ref) : super(GameState.active);

  final StateNotifierProviderRef _ref;
  final _log = CustomLogger('GameStateNotifier');

  void endGame() {
    _ref.read(scoreProvider.notifier).updateBestScore();
    state = GameState.ended;
    _log.info('Game ended');
  }

  void restartGame() {
    _ref.read(boardProvider.notifier).initializeBoard();
    _ref.read(scoreProvider.notifier).resetScore();
    _ref.read(movesProvider.notifier).resetMoves();
    state = GameState.active;
    _log.info('Game restarted');
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(ref),
);
