import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovesNotifier extends StateNotifier<int> {
  MovesNotifier() : super(0);

  void add() => state += 1;
  void reset() => state = 0;
}

final movesProvider = StateNotifierProvider<MovesNotifier, int>(
  (ref) => MovesNotifier(),
);
