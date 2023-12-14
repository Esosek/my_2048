import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.restart_alt_rounded,
          ),
        ),
      ),
    );
  }
}
