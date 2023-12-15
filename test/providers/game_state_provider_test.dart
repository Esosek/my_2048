import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_2048/providers/game_state_provider.dart';

void main() {
  ProviderContainer setProvider() {
    final sut = ProviderContainer();
    addTearDown(() => sut.dispose());
    return sut;
  }

  group('GameStateNotifier', () {
    test('initializes with active state', () {
      final sut = setProvider();
      final initialState = sut.read(gameStateProvider);

      expect(initialState, equals(GameState.active));
    });

    test('ends game with ended state', () {
      final sut = setProvider();
      sut.read(gameStateProvider.notifier).endGame();

      final currentState = sut.read(gameStateProvider);

      expect(currentState, equals(GameState.ended));
    });

    test('resets the state from ended to active', () {
      final sut = setProvider();
      sut.read(gameStateProvider.notifier).endGame();
      sut.read(gameStateProvider.notifier).restartGame();

      final currentState = sut.read(gameStateProvider);

      expect(currentState, equals(GameState.active));
    });
  });
}
