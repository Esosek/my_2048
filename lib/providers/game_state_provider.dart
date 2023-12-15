import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/providers/board_provider.dart';
import 'package:my_2048/providers/moves_provider.dart';
import 'package:my_2048/providers/score_provider.dart';

enum GameState { active, ended }

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(this.ref) : super(GameState.active);

  final StateNotifierProviderRef ref;

  void endGame() {
    state = GameState.ended;
    ref.read(scoreProvider.notifier).updateBestScore();
  }

  void restartGame() {
    ref.read(boardProvider.notifier).initializeBoard();
    ref.read(scoreProvider.notifier).resetScore();
    ref.read(movesProvider.notifier).resetMoves();
    state = GameState.active;
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(ref),
);
