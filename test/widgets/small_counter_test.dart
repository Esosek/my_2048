import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/widgets/small_counter.dart';

void main() {
  group('SmallCounter', () {
    testWidgets('displays the provided title and value', (widgetTester) async {
      const title = 'best score';
      const value = '32';

      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmallCounter(
              title: title,
              value: value,
            ),
          ),
        ),
      );

      expect(find.text(title.toUpperCase()), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });
  });
}
