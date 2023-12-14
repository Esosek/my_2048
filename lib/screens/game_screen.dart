import 'package:flutter/material.dart';

import 'package:my_2048/components/board.dart';
import 'package:my_2048/components/reset_button.dart';
import 'package:my_2048/components/score_counter.dart';
import 'package:my_2048/components/small_counter.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 239),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ScoreCounter(),
                  ),
                  const SizedBox(width: 8),
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
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: SmallCounter(
                                title: 'Moves',
                                value: '0',
                              ),
                            ),
                            const SizedBox(width: 8),
                            ResetButton()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Board(),
            ],
          )),
    );
  }
}
