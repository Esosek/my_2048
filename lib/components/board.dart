import 'package:flutter/material.dart';

import 'package:my_2048/components/board_tile.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          padding: const EdgeInsets.all(4),
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(16, (_) => const BoardTile()),
        ),
      ),
    );
  }
}
