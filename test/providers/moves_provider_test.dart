import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/providers/moves_provider.dart';

void main() {
  group('MovesNotifier', () {
    ProviderContainer setProvider() {
      final sut = ProviderContainer();
      addTearDown(() => sut.dispose());
      return sut;
    }

    test('initializes with 0 moves', () {
      final sut = setProvider();
      final initialMovesCount = sut.read(movesProvider);

      expect(initialMovesCount, equals(0));
    });

    test('correctly increments moves by 1', () {
      final sut = setProvider();
      sut.read(movesProvider.notifier).addMove();

      expect(sut.read(movesProvider), equals(1));
    });

    test('correctly reset moves to 0', () {
      final sut = setProvider();
      // First set the the moves to 1
      sut.read(movesProvider.notifier).addMove();
      expect(sut.read(movesProvider), equals(1));

      sut.read(movesProvider.notifier).resetMoves();

      expect(sut.read(movesProvider), equals(0));
    });
  });
}
