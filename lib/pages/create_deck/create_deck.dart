import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/pages/element_colors.dart';
import 'package:frontend/widgets/flashcards.dart';
import 'package:frontend/layout/app_shell.dart';

class CreateDeckPage extends StatelessWidget {
  const CreateDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Expanded(child: _DeckForm())],
        ),
      ),
    );
  }
}

class _DeckForm extends StatefulWidget {
  const _DeckForm({super.key});

  @override
  State<_DeckForm> createState() => _DeckFormState();
}

class _DeckFormState extends State<_DeckForm> {
  final List<Flashcard> _flashcards = [];
  final TextEditingController _deckNameController = TextEditingController();
  final TextEditingController _deckDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _addCard();
    }
  }

  Future<void> createDeckWithCards({
    required String name,
    required String description,
    required List<Map<String, String>>
    cards,
  }) async {
    // STEP 0: Create deck and get deck_id
    final response = await ApiService.dio.post(
      'http://localhost:8080/decks',
      data: {'name': name, 'description': description},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Failed to create deck. Status: ${response.statusCode}');
      return;
    }

    final Map<String, dynamic> deckData = response.data;
    final String deckId = deckData['deck_id'];
    print('Created deck with ID: $deckId');

    // STEP 1: Add each card and get card_id
    for (final card in cards) {
      final cardId = await ApiService().addCardString(
        word: card['word'] ?? '',
        translation: card['translation'] ?? '',
      );
      // String? cardId = result?['card_id']?.toString();

      if (cardId == null) {
        print('Skipping card: failed to add ${card['word']}');
        continue;
      }

      // STEP 2: Link card to deck
      final addToDeckSuccess = await ApiService().addCardToDeck(
        deckId: deckId,
        cardId: cardId,
      );

      if (addToDeckSuccess) {
        print('Card $cardId added to deck $deckId');
      } else {
        print('Failed to add card $cardId to deck $deckId');
      }
    }
  }

  @override
  void dispose() {
    _deckNameController.dispose();
    _deckDescriptionController.dispose();
    for (var card in _flashcards) {
      card.wordController.dispose();
      card.translationController.dispose();
    }
    super.dispose();
  }

  void _addCard() {
    setState(() {
      final String uniqueId = DateTime.now().microsecondsSinceEpoch.toString();
      _flashcards.add(
        Flashcard(
          id: uniqueId,
          wordController: TextEditingController(),
          translationController: TextEditingController(),
        ),
      );
    });
  }

  void _removeCard(int index) {
    setState(() {
      _flashcards[index].wordController.dispose();
      _flashcards[index].translationController.dispose();
      _flashcards.removeAt(index);
    });
  }

  Future<void> _submitDeck() async {
    final name = _deckNameController.text.trim();
    final description = _deckDescriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deck name and description are required')),
      );
      return;
    }

    final List<Map<String, String>> cards = _flashcards
        .where(
          (card) =>
              card.wordController.text.trim().isNotEmpty &&
              card.translationController.text.trim().isNotEmpty,
        )
        .map(
          (card) => {
            'word': card.wordController.text.trim(),
            'translation': card.translationController.text.trim(),
          },
        )
        .toList();

    if (cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one card')),
      );
      return;
    }

    await createDeckWithCards(
      name: name,
      description: description,
      cards: cards,
    );

    if (!mounted) return;

    // Navigate back after a short delay to let user see the success message
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AppShell(),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),

        TextField(
          controller: _deckNameController,
          decoration: InputDecoration(
            hintText: 'Enter title',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _deckDescriptionController,
          decoration: InputDecoration(
            hintText: 'Enter description',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        const SizedBox(height: 16),

        ...List.generate(_flashcards.length, (index) {
          final card = _flashcards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(color: Colors.purple),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeCard(index),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: card.wordController,
                            decoration: const InputDecoration(
                              hintText: 'Word',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 40),
                        Expanded(
                          child: TextField(
                            controller: card.translationController,
                            decoration: const InputDecoration(
                              hintText: 'Translation',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: _addCard,
            icon: const Icon(Icons.add),
            label: const Text('Add Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ElementColors.buttonColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: _submitDeck,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text('Create Deck'),
          ),
        ),
      ],
    );
  }
}
