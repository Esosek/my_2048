import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/widgets/score_counter.dart';
import 'package:my_2048/providers/game_state_provider.dart';
import 'package:my_2048/providers/score_provider.dart';

void main() {
  late ProviderContainer providerContainer;

  void setProviders() {
    providerContainer = ProviderContainer();
    addTearDown(() => providerContainer.dispose());
  }

  Widget widgetTree() {
    setProviders();
    return UncontrolledProviderScope(
      container: providerContainer,
      child: const MaterialApp(
        home: ScoreCounter(),
      ),
    );
  }

  group('ScoreCounter', () {
    testWidgets('initializes with zero value', (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('updates correctly when score provider value changes',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());
      const updatedScore = 8;

      providerContainer.read(scoreProvider.notifier).addScore(updatedScore);
      await widgetTester.pump();

      expect(find.text(updatedScore.toString()), findsOneWidget);
    });

    testWidgets('displays correctly zero value when game resets',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());

      providerContainer.read(scoreProvider.notifier).addScore(8);
      providerContainer.read(gameStateProvider.notifier).restartGame();
      await widgetTester.pump();

      expect(find.text('0'), findsOneWidget);
    });
  });
}
