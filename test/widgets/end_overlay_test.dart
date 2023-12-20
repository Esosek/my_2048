import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_2048/providers/score_provider.dart';
import 'package:my_2048/widgets/end_overlay.dart';

void main() {
  group('EndOverlayWidget', () {
    testWidgets('correctly displays final score', (widgetTester) async {
      final providerContainer = ProviderContainer();
      addTearDown(() => providerContainer.dispose());

      Widget widgetTree = UncontrolledProviderScope(
        container: providerContainer,
        child: const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                EndOverlay(),
              ],
            ),
          ),
        ),
      );

      const scoreValue = 8;

      providerContainer.read(scoreProvider.notifier).addScore(scoreValue);
      await widgetTester.pumpWidget(widgetTree);

      expect(find.text('Final score: $scoreValue'), findsOneWidget);
    });
  });
}
