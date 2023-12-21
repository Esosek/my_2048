import 'package:flutter/material.dart';

import 'package:my_2048/models/tile.dart';

class BoardTile extends StatefulWidget {
  const BoardTile(this.tile, {super.key});

  final Tile tile;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    if (widget.tile.isGenerated) {
      _controller.forward(from: widget.tile.isEmpty ? 1.0 : 0.0);
    }
  }

  @override
  void didUpdateWidget(BoardTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handles new tiles generation animation
    if (widget.tile.isGenerated && !widget.tile.isEmpty) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        color: widget.tile.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            child: widget.tile.isEmpty
                ? null
                : Text(
                    widget.tile.value.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: widget.tile.value <= 4
                              ? const Color.fromARGB(255, 118, 109, 101)
                              : null,
                          fontSize: 34,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
