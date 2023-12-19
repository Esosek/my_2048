import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/components/board_tile.dart';
import 'package:my_2048/models/tile.dart';

void main() {
  ThemeData theme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 232, 226, 220),
    ),
  );

  Widget widgetTreeWithTile(Tile tile) {
    return MaterialApp(
      theme: theme.copyWith(
        textTheme: const TextTheme().copyWith(
            bodyLarge: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 26,
        )),
      ),
      home: Scaffold(
        body: BoardTile(tile),
      ),
    );
  }

  void testTextColor(WidgetTester tester, Color expectedColor) {
    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style!.color, equals(expectedColor));
  }

  group('BoardTile', () {
    testWidgets(
      'displays non-zero value of provided tile',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetTreeWithTile(
          Tile(value: 4),
        ));

        expect(find.text('4'), findsOneWidget);
      },
    );

    testWidgets(
      'does not display any text when tile value is zero',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetTreeWithTile(
          Tile(value: 0),
        ));

        expect(find.byType(Text), findsNothing);
      },
    );

    testWidgets(
      'displays dark text when provided tile value is 2',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetTreeWithTile(
          Tile(value: 2),
        ));

        const expectedColor = Color.fromARGB(255, 118, 109, 101);
        testTextColor(widgetTester, expectedColor);
      },
    );

    testWidgets(
      'displays dark text when provided tile value is 4',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetTreeWithTile(
          Tile(value: 4),
        ));

        const expectedColor = Color.fromARGB(255, 118, 109, 101);
        testTextColor(widgetTester, expectedColor);
      },
    );

    testWidgets(
      'displays light text when provided tile value is bigger than 4',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetTreeWithTile(
          Tile(value: 8),
        ));

        final expectedColor = theme.colorScheme.onPrimary;
        testTextColor(widgetTester, expectedColor);
      },
    );
  });
}
