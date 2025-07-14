import 'package:flutter/material.dart';

class AnswerButtons extends StatelessWidget {
  final void Function(String rating) onRate;
  final VoidCallback onAgain;

  const AnswerButtons({
    super.key,
    required this.onRate,
    required this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['Hard', 'Good', 'Easy'];
    final ratings = ['hard', 'good', 'easy'];
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Again Button
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: ElevatedButton(
              onPressed: onAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.tertiary,
                foregroundColor: colors.onTertiary,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Again',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          // Rating Buttons
          ...List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: () => onRate(ratings[i]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  labels[i],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}