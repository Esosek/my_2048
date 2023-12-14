import 'package:flutter/material.dart';

class ScoreCounter extends StatelessWidget {
  const ScoreCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Score',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          '57567',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
