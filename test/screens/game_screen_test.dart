import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/widgets/board.dart';
import 'package:my_2048/widgets/end_overlay.dart';
import 'package:my_2048/widgets/score_counter.dart';
import 'package:my_2048/widgets/small_counter.dart';
import 'package:my_2048/providers/game_state_provider.dart';
import 'package:my_2048/providers/moves_provider.dart';
import 'package:my_2048/providers/score_provider.dart';
import 'package:my_2048/screens/game_screen.dart';

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
        home: GameScreen(),
      ),
    );
  }

  group('GameScreen', () {
    testWidgets('renders SmallCounters widgets with provider values',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());
      final scoreProviderNotifier =
          providerContainer.read(scoreProvider.notifier);

      // Change provider values to test if UI is updated correctly
      providerContainer.read(movesProvider.notifier).addMove();
      scoreProviderNotifier.addScore(8);
      await widgetTester.pump();

      final smallCounterWidgets = find.byType(SmallCounter);
      expect(smallCounterWidgets, findsNWidgets(2));

      final smallCounterTexts = widgetTester
          .widgetList<Text>(
            find.descendant(
              of: smallCounterWidgets,
              matching: find.byType(Text),
            ),
          )
          .map((widget) => widget.data)
          .toList();

      expect(smallCounterTexts, contains('8')); // Best score counter
      expect(smallCounterTexts, contains('1')); // Moves counter
    });

    testWidgets('always renders ScoreCounter and Board', (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());

      expect(find.byType(ScoreCounter), findsOneWidget);
      expect(find.byType(Board), findsOneWidget);
    });

    testWidgets('does not render EndOverlay widget when game state is active',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());

      expect(find.byType(EndOverlay), findsNothing);
    });

    testWidgets('renders EndOverlay widget when game state is ended',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetTree());

      providerContainer.read(gameStateProvider.notifier).endGame();
      await widgetTester.pump();

      expect(find.byType(EndOverlay), findsOneWidget);
    });
  });
}
