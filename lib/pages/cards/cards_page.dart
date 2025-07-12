import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cards = [
      'Hello', 'House', 'Sun', 'Tree', 'Moon', 'Star', 'Cloud', 'Rain',
      'Book', 'Pen', 'Phone', 'Laptop', 'Table', 'Chair', 'Car', 'Bike',
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '421 cards',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                itemCount: cards.length,
                padding: const EdgeInsets.only(top: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Text(
                        cards[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
