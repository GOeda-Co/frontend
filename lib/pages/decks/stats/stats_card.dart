import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const StatCard({
    super.key,
    required this.value,
    required this.unit,
    required this.label,
  }); 

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 240),
        margin: const EdgeInsets.only(right: 12), // spacing between cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
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
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (unit.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 6),
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontSize: 36, 
                        color: colorScheme.onSurface
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, 
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
