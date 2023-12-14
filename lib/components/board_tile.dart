import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 238, 227, 218),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.scaleDown,
          child: Text(
            '2',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: const Color.fromARGB(255, 118, 109, 101),
                  fontSize: 34,
                ),
          ),
        ),
      ),
    );
  }
}
