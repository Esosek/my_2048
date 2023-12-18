import 'package:flutter/material.dart';

import 'package:my_2048/models/tile.dart';

class BoardTile extends StatelessWidget {
  const BoardTile(this.tile, {super.key});

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tile.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.scaleDown,
          child: tile.isEmpty
              ? null
              : Text(
                  tile.value.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: tile.value <= 4
                            ? const Color.fromARGB(255, 118, 109, 101)
                            : null,
                        fontSize: 34,
                      ),
                ),
        ),
      ),
    );
  }
}
