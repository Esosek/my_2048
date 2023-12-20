import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/providers/score_provider.dart';

class ScoreCounter extends ConsumerWidget {
  const ScoreCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScore = ref.watch(scoreProvider)[Score.current]!;
    return Column(
      children: [
        Text(
          'Score',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          currentScore.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: const Color.fromARGB(255, 118, 109, 101),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
