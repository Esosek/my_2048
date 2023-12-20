import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/widgets/board.dart';
import 'package:my_2048/widgets/board_tile.dart';
import 'package:my_2048/providers/board_provider.dart';

void main() {
  ProviderContainer setProviders() {
    final providerContainer = ProviderContainer();
    addTearDown(() => providerContainer.dispose());
    return providerContainer;
  }

  Widget widgetTree(ProviderContainer providerContainer) {
    return UncontrolledProviderScope(
      container: providerContainer,
      child: const MaterialApp(
        home: Scaffold(
          body: Board(),
        ),
      ),
    );
  }

  group('BoardWidget', () {
    testWidgets(
      'displays error message when boardProvider lenght is not 16',
      (widgetTester) async {
        final providerContainer = ProviderContainer(overrides: [
          boardProvider.overrideWith(
            (ref) =>
                BoardProviderNotifier.withValue(ref: ref, initialValue: []),
          ),
        ]);
        addTearDown(() => providerContainer.dispose());

        await widgetTester.pumpWidget(widgetTree(providerContainer));

        expect(find.textContaining('Something went wrong'), findsOneWidget);
        expect(find.byType(BoardTile), findsNothing);
      },
    );

    testWidgets('displays 16 game tiles with provided values',
        (widgetTester) async {
      final providerContainer = setProviders();
      await widgetTester.pumpWidget(widgetTree(providerContainer));

      final gameTileFinders = find.byType(BoardTile);
      expect(gameTileFinders, findsNWidgets(16));

      final tileWidgets = widgetTester.widgetList<BoardTile>(gameTileFinders);

      for (BoardTile tileWidget in tileWidgets) {
        final tileValue = tileWidget.tile.value;
        final textFinder = find.descendant(
            of: find.byWidget(tileWidget), matching: find.byType(Text));

        if (tileValue == 0) {
          expect(textFinder, findsNothing);
        } else {
          expect(textFinder, findsOneWidget);
          final textWidget = widgetTester.firstWidget<Text>(textFinder);
          final displayedText = textWidget.data;

          expect(displayedText, tileValue.toString());
        }
      }
    });
  });
}
