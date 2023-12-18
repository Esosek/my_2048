import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_2048/components/board_tile.dart';
import 'package:my_2048/providers/board_provider.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTiles = ref.watch(boardProvider);
    final hasError = gameTiles.length != 16;

    final errorWidget = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          'Something went wrong, please restart the game!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
        ),
      ),
    );

    return SizedBox(
      height: hasError ? 400 : null,
      width: MediaQuery.of(context).size.width > 400 ? 400 : double.infinity,
      child: Card(
        child: hasError
            ? errorWidget
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                padding: const EdgeInsets.all(4),
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    gameTiles.length, (index) => BoardTile(gameTiles[index])),
              ),
      ),
    );
  }
}
