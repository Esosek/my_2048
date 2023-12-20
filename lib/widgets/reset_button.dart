import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/providers/game_state_provider.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      child: Card(
        child: IconButton(
          onPressed: () => ref.read(gameStateProvider.notifier).endGame(),
          icon: const Icon(
            Icons.restart_alt_rounded,
          ),
        ),
      ),
    );
  }
}
