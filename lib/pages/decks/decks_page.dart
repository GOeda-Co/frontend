import 'package:flutter/material.dart';
import 'recents/recents.dart';
import 'stats/stats.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecentsSection(),
            const SizedBox(height: 48),
            StatsSection(),
          ],
        ),
      ),
    );
  }
}
