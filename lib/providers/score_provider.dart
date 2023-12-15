import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_2048/utilities/custom_logger.dart';

enum Score { current, best }

class ScoreNotifier extends StateNotifier<Map<Score, int>> {
  ScoreNotifier() : super({Score.current: 0, Score.best: 0});

  // Constructor for mocking initial values in testing
  ScoreNotifier.test(Map<Score, int> initialState) : super(initialState);

  final _log = CustomLogger('ScoreNotifier');

  void addScore(int value) {
    final updatedScore = state[Score.current]! + value;
    state = {...state, Score.current: updatedScore};

    _log.trace('Current score increased to $updatedScore');
  }

  void resetScore() {
    state = {...state, Score.current: 0};
    _log.trace('Current score set to 0');
  }

  void updateBestScore() {
    final currentScore = state[Score.current]!;

    if (currentScore > state[Score.best]!) {
      state = {...state, Score.best: currentScore};
      _log.trace('Best score was updated to $currentScore');
    }
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, Map<Score, int>>(
  (ref) => ScoreNotifier(),
);
