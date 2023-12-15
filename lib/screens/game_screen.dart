import 'package:flutter/material.dart';

import 'package:my_2048/components/board.dart';
import 'package:my_2048/components/end_overlay.dart';
import 'package:my_2048/components/reset_button.dart';
import 'package:my_2048/components/score_counter.dart';
import 'package:my_2048/components/small_counter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isGameOver = false;

  @override
  Widget build(BuildContext context) {
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
                            ResetButton()
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
                  if (_isGameOver) const EndOverlay(),
                ],
              ),
            ],
          )),
    );
  }
}
