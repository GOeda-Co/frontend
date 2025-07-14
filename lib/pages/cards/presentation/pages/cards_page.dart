import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import '../widgets/card_item.dart';
import '../widgets/card_creation_menu.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final List<String> _cards = [];

  void loadCards() async {
    final parsedJson = await ApiService.getAllCards();

    if (parsedJson != null) {
      setState(() {
        _cards.clear();
        _cards.addAll(
          parsedJson
              .map<String>((card) => '${card['word']} - ${card['translation']}')
              .toList(),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  void _showCreationMenu() {
    showDialog(
      context: context,
      builder: (context) => CardCreationMenu(
        onCreate: (term, definition) {
          setState(() {
            _cards.add(term);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_cards.length} cards',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: _showCreationMenu,
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 28,
                    color: colors.primary,
                  ),
                  tooltip: 'Add card',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: _cards.length,
                padding: const EdgeInsets.only(top: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return CardItem(word: _cards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
