import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/providers/score_provider.dart';

void main() {
  late StateNotifierProvider<ScoreNotifier, Map<Score, int>> mockScoreProvider;

  ProviderContainer setProvider(Map<Score, int> initialValues) {
    mockScoreProvider = StateNotifierProvider<ScoreNotifier, Map<Score, int>>(
      (ref) => ScoreNotifier.test(initialValues),
    );

    final sut = ProviderContainer();
    addTearDown(() => sut.dispose());
    return sut;
  }

  group('ScoreNotifier', () {
    test('initializes with current and best scores as 0', () {
      final sut = ProviderContainer();
      addTearDown(() => sut.dispose());

      final scoreMap = sut.read(scoreProvider);

      expect(scoreMap[Score.current], equals(0));
      expect(scoreMap[Score.best], equals(0));
    });

    test('correctly increments current score with provided value', () {
      final sut = setProvider({Score.current: 2});
      final initialScore = sut.read(mockScoreProvider)[Score.current]!;
      const scoreIncrement = 4;

      final expectedScore = initialScore + scoreIncrement;
      sut.read(mockScoreProvider.notifier).addScore(scoreIncrement);

      expect(sut.read(mockScoreProvider)[Score.current], equals(expectedScore));
    });

    test('resets current score to zero while keeping best score unchanged', () {
      final sut = setProvider({Score.current: 2, Score.best: 8});
      final initialBestScore = sut.read(mockScoreProvider)[Score.best]!;

      sut.read(mockScoreProvider.notifier).resetScore();

      final scoreMap = sut.read(mockScoreProvider);

      expect(scoreMap[Score.current], equals(0));
      expect(scoreMap[Score.best], equals(initialBestScore));
    });

    test('updates best score only if current score is higher', () {
      final sut = setProvider({Score.current: 10, Score.best: 8});
      final score = sut.read(mockScoreProvider)[Score.current]!;

      sut.read(mockScoreProvider.notifier).updateBestScore();

      expect(sut.read(mockScoreProvider)[Score.best], equals(score));
    });

    test('does not update best score if current score is lower', () {
      final sut = setProvider({Score.current: 6, Score.best: 8});
      final bestScore = sut.read(mockScoreProvider)[Score.best]!;

      sut.read(mockScoreProvider.notifier).updateBestScore();

      expect(sut.read(mockScoreProvider)[Score.best], equals(bestScore));
    });
  });
}
