import 'package:flutter/material.dart';

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
            // Recents Section
            // const SizedBox(width: 20),
            RecentsSection(),

            const SizedBox(height: 48),
            // const SizedBox(width: 20),
            // Stats Section
            StatsSection(),
          ],
        ),
      ),
    );
  }
}

class RecentsSection extends StatelessWidget {
  final List<Map<String, dynamic>> recents = [
    {'title': 'D1-20', 'cards': 12},
    {'title': 'D1-10', 'cards': 24},
    {'title': 'D1-11', 'cards': 53},
    {'title': 'D1-18', 'cards': 224},
    {'title': 'D1-18', 'cards': 26},
    {'title': 'D1-5', 'cards': 95},
    {'title': 'D1-12', 'cards': 10},
    {'title': 'D1-18', 'cards': 23},
    {'title': 'D1-18', 'cards': 23},
    {'title': 'D1-18', 'cards': 23},
    {'title': 'D1-18', 'cards': 23},
    {'title': 'D1-18', 'cards': 23},
  ];

  RecentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recents',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 240, // controls scrollable height
          child: GridView.builder(
            itemCount: recents.length,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3.8,
            ),
            itemBuilder: (context, index) {
              final item = recents[index];
              return _RecentCard(
                title: item['title'],
                cardCount: item['cards'],
                onIconTap: () {
                  debugPrint('Tapped icon on ${item['title']}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentCard extends StatelessWidget {
  final String title;
  final int cardCount;
  final VoidCallback onIconTap;

  const _RecentCard({
    required this.title,
    required this.cardCount,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onIconTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.view_agenda, size: 24),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('$cardCount cards', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Statistics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StatCard(value: '13', unit: 'words', label: 'learned today'),
            _StatCard(value: '4,6', unit: '', label: 'average grade'),
            _StatCard(value: '241', unit: 'words', label: 'already learned'),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const _StatCard({
    required this.value,
    required this.unit,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 240),
        margin: const EdgeInsets.only(right: 12), // spacing between cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Value + unit line
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (unit.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 6),
                    child: Text(
                      unit,
                      style: const TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
