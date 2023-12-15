import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/components/board.dart';
import 'package:my_2048/components/end_overlay.dart';
import 'package:my_2048/components/reset_button.dart';
import 'package:my_2048/components/score_counter.dart';
import 'package:my_2048/components/small_counter.dart';
import 'package:my_2048/providers/game_state_provider.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 239),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ScoreCounter(),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SmallCounter(
                            title: 'Best score',
                            value: '8',
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: SmallCounter(
                                title: 'Moves',
                                value: '0',
                              ),
                            ),
                            SizedBox(width: 8),
                            ResetButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Board(),
                  if (gameState == GameState.ended) const EndOverlay(),
                ],
              ),
            ],
          )),
    );
  }
}
