import 'package:flutter/material.dart';
import 'package:my_2048/components/reset_button.dart';

class EndOverlay extends StatelessWidget {
  const EndOverlay({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Score: 8',
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
