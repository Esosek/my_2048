import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/components/reset_button.dart';

void main() {
  group('ResetButton', () {
    testWidgets('renders IconButton with the correct icon',
        (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ResetButton(),
          ),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt_rounded), findsOneWidget);
    });
  });
}
