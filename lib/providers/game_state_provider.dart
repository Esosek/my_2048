import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/providers/board_provider.dart';
import 'package:my_2048/providers/moves_provider.dart';
import 'package:my_2048/providers/score_provider.dart';
import 'package:my_2048/utilities/custom_logger.dart';

enum GameState { active, ended }

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(this.ref) : super(GameState.active);

  final StateNotifierProviderRef ref;
  final _log = CustomLogger('GameStateNotifier');

  void endGame() {
    state = GameState.ended;
    ref.read(scoreProvider.notifier).updateBestScore();
    _log.info('Game ended');
  }

  void restartGame() {
    ref.read(boardProvider.notifier).initializeBoard();
    ref.read(scoreProvider.notifier).resetScore();
    ref.read(movesProvider.notifier).resetMoves();
    state = GameState.active;
    _log.info('Game restarted');
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(ref),
);
