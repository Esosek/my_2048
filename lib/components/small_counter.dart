import 'package:flutter/material.dart';

class SmallCounter extends StatelessWidget {
  const SmallCounter({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
