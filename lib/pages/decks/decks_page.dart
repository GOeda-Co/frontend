import 'package:flutter/material.dart';
import 'package:frontend/pages/decks/recents/recents.dart';
import 'package:frontend/pages/decks/stats/stats.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
