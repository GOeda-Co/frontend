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
      _showBack = false;
      currentIndex = (currentIndex + 1) % cards.length;
    });
  }

  void prevCard() {
    if (cards.isEmpty) return;
    setState(() {
      _showBack = false;
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
    final bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Text('Delete Deck?', style: TextStyle(color: colorScheme.onSurface)),
          content: Text('Are you sure you want to delete "${widget.deckName}"? This action cannot be undone.',
              style: TextStyle(color: colorScheme.onSurfaceVariant)),
          backgroundColor: colorScheme.surfaceContainerHigh,
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: colorScheme.onSurface)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: colorScheme.error)), // Use error color for destructive action
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    ) ?? false; // Default to false if dialog is dismissed

    if (confirmDelete) {
      final success = await ApiService().deleteDeck(widget.deckId);
      if (success && mounted) {
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deck "${widget.deckName}" deleted successfully!',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
        Navigator.pop(context); // Go back to the previous screen (DecksPage)
      } else if (mounted) {
        // Show failure snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete deck "${widget.deckName}"',
                style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    }
  }

  

  void _flipCard() {
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(widget.deckName, 
                    style: TextStyle(color: colorScheme.onSurface)
                ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnkiApp())),
        ),
        actions: [
          TextButton.icon(
            onPressed: cards.isNotEmpty ? onStudyPressed : null,
            icon: Icon(Icons.keyboard_return, color: colorScheme.onPrimary),
            style: TextButton.styleFrom(backgroundColor: colorScheme.primary),
            label: Text('Study', style: TextStyle(color: colorScheme.onPrimary)),
          ),

          const SizedBox(width: 8),

          TextButton.icon(
            onPressed: onDeletePressed,
            icon: Icon(Icons.delete, color: colorScheme.onError),
            style: TextButton.styleFrom(backgroundColor: colorScheme.error, // Button color from theme
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)), // Adjusted padding
            label: Text('Delete', style: TextStyle(color: colorScheme.onError)),
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
                color: colorScheme.primary, // Theme loading indicator
              ),)
          : cards.isEmpty
          ? Center(child: Text('No cards in this deck.', style: TextStyle(color: colorScheme.onSurface)))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                          final rotate = Tween(begin: 0.0, end: 1.0).animate(animation);
                          return AnimatedBuilder(
                            animation: rotate,
                            child: child,
                            builder: (BuildContext context, Widget? child) {
                              final isFront = _showBack;
                              final angle = isFront ? (rotate.value * 3.14159) : (-(rotate.value * 3.14159)); // Rotate 180 degrees
                              final value = rotate.value;
                              final matrix = Matrix4.identity()
                                ..setEntry(3, 2, 0.001) // Perspective
                                ..rotateY(value * (isFront ? -3.14159 : 3.14159)); // Y-axis rotation
                              return Transform(
                                transform: matrix,
                                alignment: Alignment.center,
                                child: child,
                              );
                            },
                          );
                        },
                    child: Container(
                      key: ValueKey<bool>(_showBack),
                      width: 450,
                      height: 350,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _showBack
                            ? (cards[currentIndex]['translation'] ?? 'No translation available')
                            : cards[currentIndex]['word'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: colorScheme.onSurface,
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
                      icon: Icon(
                        Icons.arrow_left,
                        size: 32,
                        color: colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 20),

                    IconButton(
                      onPressed: nextCard,
                      icon: Icon(
                        Icons.arrow_right,
                        size: 32,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
