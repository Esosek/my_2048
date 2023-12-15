import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovesNotifier extends StateNotifier<int> {
  MovesNotifier() : super(0);

  void increment() => state += state;
  void reset() => state = 0;
}

final movesProvider = StateNotifierProvider<MovesNotifier, int>(
  (ref) => MovesNotifier(),
);
