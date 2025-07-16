import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/pages/deck_info/deck_info.dart';
import 'recents_deck_card.dart';

class RecentsSection extends StatefulWidget {
  const RecentsSection({super.key});

  @override
  State<RecentsSection> createState() => _RecentsSectionState();
}

class _RecentsSectionState extends State<RecentsSection> {
  List<Map<String, dynamic>> recents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecents();
  }

  Future<void> fetchRecents() async {
    final result = await ApiService.getAllDecksAsSimpleMap();
    setState(() {
      recents = result ?? [];
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
          'Recents',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 240,
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
              return RecentCard(
                title: item['title'],
                cardCount: item['cards'],
                onIconTap: () {
                  print(item['deck_id']);
                  print(item['title']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlashcardPage(deckId: item['deck_id'], deckName: item['title'],)),
                  );
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
