import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_2048/providers/score_provider.dart';

import 'package:my_2048/widgets/reset_button.dart';

class EndOverlay extends ConsumerWidget {
  const EndOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finalScore = ref.watch(scoreProvider)[Score.current];
    return Positioned.fill(
      child: Card(
        color: const Color.fromARGB(190, 237, 207, 115),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Final score: $finalScore',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 17,
                  ),
            ),
            const SizedBox(height: 16),
            const ResetButton(),
          ],
        ),
      ),
    );
  }
}
