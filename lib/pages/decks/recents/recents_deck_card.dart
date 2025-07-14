import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  final String title;
  final int cardCount;
  final VoidCallback onIconTap;

  const RecentCard({
    super.key,
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
