import 'package:flutter/material.dart';

class AnswerButtons extends StatelessWidget {
  final String cardId;
  final void Function(String cardId, String rating) onRate;

  const AnswerButtons({
    super.key,
    required this.cardId,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['Don’t know', '', '', '', 'Know perfectly'];
    final ratings = ['1', '2', '3', '4', '5'];
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => onRate(cardId, ratings[i]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: Text(
                    ratings[i],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  labels[i],
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
