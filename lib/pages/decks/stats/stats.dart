import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'stats_card.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  int? wordsLearned;
  double? averageGrade;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final count = await ApiService.getCardsReviewedCount();
    final avg = await ApiService.getAverageGrade();

    setState(() {
      wordsLearned = count ?? 0;
      averageGrade = avg ?? 0.0;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
        );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: TextStyle(
            fontSize: 24, // Increased font size for section title
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface, // Use theme's color for section title
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatCard(
              value: wordsLearned.toString(),
              unit: 'words',
              label: 'learned today',
            ),
            StatCard(
              value: averageGrade!.toStringAsFixed(1),
              unit: '',
              label: 'average grade',
            ),
            const StatCard(
              value: 'You',
              unit: 'are',
              label: 'perfect!',
            ),
          ],
        ),
      ],
    );
  }
}
