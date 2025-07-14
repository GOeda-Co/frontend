import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String word;

  const CardItem({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Text(
          word,
          style: TextStyle(
            fontSize: 16,
            color: colors.onSurface,
          ),
        ),
      ),
    );
  }
}