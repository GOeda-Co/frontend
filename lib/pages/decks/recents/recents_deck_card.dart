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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        InkWell(
          onTap: onIconTap,
          child: Card(
            color: colorScheme.secondaryContainer, // Use a themed container color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero, // Remove default Card margin
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.view_agenda,
                size: 24,
                color: colorScheme.onSecondaryContainer, // Icon color on the container
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: colorScheme.onSurface
                  )
              ),
              Text(
                '$cardCount cards', 
                style: TextStyle(
                  fontSize: 12, 
                  color: colorScheme.onSurface.withAlpha((0.7 * 255).toInt())
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
