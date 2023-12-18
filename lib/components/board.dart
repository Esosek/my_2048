import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/components/board_tile.dart';
import 'package:my_2048/providers/board_provider.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTiles = ref.watch(boardProvider);
    return SizedBox(
      width: MediaQuery.of(context).size.width > 400 ? 400 : double.infinity,
      child: Card(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          padding: const EdgeInsets.all(4),
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(16, (index) => BoardTile(gameTiles[index])),
        ),
      ),
    );
  }
}
