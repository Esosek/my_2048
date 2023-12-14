import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // TODO: Add Tile backgroundColor
      color: const Color.fromARGB(255, 238, 227, 218),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.scaleDown,
          child: Text(
            '2',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  // TODO: Add dark color for 2 and 4
                  // TODO: Add light color for rest
                  color: const Color.fromARGB(255, 118, 109, 101),
                  fontSize: 34,
                ),
          ),
        ),
      ),
    );
  }
}
