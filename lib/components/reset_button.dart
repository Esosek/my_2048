import 'package:flutter/material.dart';

import 'package:my_2048/components/custom_card.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.restart_alt_rounded,
        ),
      ),
    );
  }
}
