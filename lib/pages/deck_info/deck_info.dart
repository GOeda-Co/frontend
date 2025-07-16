import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/app.dart';
import 'package:frontend/features/learning/domain/entities/learning_card.dart';
import 'package:frontend/features/learning/presentation/pages/learning_page.dart';

class FlashcardPage extends StatefulWidget {
  final String deckId;
  final String deckName;

  const FlashcardPage({
    super.key,
    required this.deckId,
    required this.deckName,
  });

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> cards = [];
  int currentIndex = 0;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _fetchDeckCards();
  }

  Future<void> _fetchDeckCards() async {
    final data = await ApiService().getCardsByDeckId(widget.deckId);
    if (mounted) {
      setState(() {
        cards = data?.cast<Map<String, dynamic>>() ?? [];
        isLoading = false;
      });
    }
  }

  void nextCard() {
    if (cards.isEmpty) return;
    setState(() {
      currentIndex = (currentIndex + 1) % cards.length;
    });
  }

  void prevCard() {
    if (cards.isEmpty) return;
    setState(() {
      currentIndex = (currentIndex - 1 + cards.length) % cards.length;
    });
  }

  void onStudyPressed() {
    final learningCards = cards.map((card) {
      return LearningCard(
        id: card['card_id'].toString(),
        front: card['word'],
        back: card['translation'] ?? '',
      );
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            LearningPage(cards: learningCards, deckId: widget.deckId),
      ),
    );
  }

  void onDeletePressed() async {
    final success = await ApiService().deleteDeck(widget.deckId);
    if (success && mounted) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to delete deck')));
    }
  }

  void _flipCard() {
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnkiApp())),
        ),
        title: Text(widget.deckName),
        actions: [
          TextButton.icon(
            onPressed: cards.isNotEmpty ? onStudyPressed : null,
            icon: const Icon(Icons.keyboard_return, color: Colors.white),
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            label: const Text('Study', style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete, color: Colors.white),
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            label: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cards.isEmpty
          ? const Center(child: Text('No cards in this deck.'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      key: ValueKey<bool>(_showBack),
                      width: 450,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _showBack
                            ? (cards[currentIndex]['translation'] ?? '')
                            : cards[currentIndex]['word'],
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: prevCard,
                      icon: const Icon(
                        Icons.arrow_left,
                        size: 32,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: nextCard,
                      icon: const Icon(
                        Icons.arrow_right,
                        size: 32,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
