import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String word;
  final String translation;

  const CardItem({
    super.key,
    required this.word,
    required this.translation,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _showFront = true;

  void _toggleSide() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _toggleSide,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Text(
          _showFront ? widget.word : widget.translation,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
      ),
    );
  }
}