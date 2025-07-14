import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/pages/decks/stats/stats_card.dart';

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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
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
              value: '241',
              unit: 'words',
              label: 'already learned',
            ),
          ],
        ),
      ],
    );
  }
}
