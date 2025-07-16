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
  final List<Map<String, String>> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards(); // Renamed for clarity
  }

  void _loadCards() async {
    // Add null check for ApiService().getAllCards()
    final List<dynamic>? parsedJson = await ApiService.getAllCards();

    if (mounted) { // Check if the widget is still in the tree
      setState(() {
        _cards.clear(); // Clear existing cards before adding new ones
        if (parsedJson != null) {
          _cards.addAll(
            parsedJson
                .map<Map<String, String>>(
                  (card) => {
                    'word': card['word'] as String, // Ensure type safety
                    'translation': card['translation'] as String, // Ensure type safety
                  },
                )
                .toList(),
          );
        }
        _isLoading = false; // Set loading to false once data is fetched
      });
    }
  }

  void _showCreationMenu() {
    showDialog(
      context: context,
      builder: (context) => CardCreationMenu(
        onCreate: (term, definition) {
          // This callback is triggered when a new card is successfully created
          // You should refresh the list of cards from the API to reflect the change
          _loadCards();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

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
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: colors.primary, // Theme loading indicator
                      ),
                    )
                  : _cards.isEmpty
                      ? Center(
                          child: Text(
                            'No cards added yet. Click the + button to add one!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: colors.onSurfaceVariant), // Themed empty state text
                          ),
                        )
                      : GridView.builder(
                          itemCount: _cards.length,
                          padding: const EdgeInsets.only(top: 8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, index) {
                            final card = _cards[index];
                            return CardItem(
                              word: card['word']!,
                              translation: card['translation']!,
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
