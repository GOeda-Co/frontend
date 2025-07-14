import 'package:flutter/material.dart';
import 'package:frontend/pages/element_colors.dart';


class CreateDeckPage extends StatelessWidget {
  const CreateDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: _DeckForm(),
            ),
          ]
        ),
      ),
    );
  }
}

// Define a simple model for your card data, including unique ID and text controllers
class Flashcard {
  final String id; // Unique ID for each card
  final TextEditingController wordController;
  final TextEditingController translationController;

  Flashcard({
    required this.id,
    required this.wordController,
    required this.translationController,
  });
}


class _DeckForm extends StatefulWidget {
  const _DeckForm({super.key});

  @override
  State<_DeckForm> createState() => _DeckFormState();
}

class _DeckFormState extends State<_DeckForm> {
  // Use a List of your custom Flashcard objects
  final List<Flashcard> _flashcards = []; 

  // Initialize some cards on initState if you want them pre-filled
  @override
  void initState() {
    super.initState();
    // Add 3 initial cards
    for (int i = 0; i < 3; i++) {
      _addCard(); 
    }
  }

  @override
  void dispose() {
    for (var card in _flashcards) {
      card.wordController.dispose();
      card.translationController.dispose();
    }
    super.dispose();
  }

  void _removeCard(int index) {
    setState(() {
      _flashcards[index].wordController.dispose();
      _flashcards[index].translationController.dispose();
      _flashcards.removeAt(index);
    });
  }

  void _addCard() {
    setState(() {
      final String uniqueId = DateTime.now().microsecondsSinceEpoch.toString();

      _flashcards.add(Flashcard(
        id: uniqueId,
        wordController: TextEditingController(),
        translationController: TextEditingController(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter description',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),

        ...List.generate(_flashcards.length, (index) {
          final Flashcard currentCard = _flashcards[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border(bottom: BorderSide(color: Colors.purple))
                    ),
                    child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black87),
                          onPressed: () => _removeCard(index),
                        ),
                      ],
                    ),
                  ), 
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: currentCard.wordController,
                            decoration: InputDecoration(
                              hintText: 'Word',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          width: 40,
                          thickness: 1,
                          indent: 8,
                          endIndent: 8,
                          color: Colors.grey[400],
                        ),
                        Expanded(
                          child: TextField(
                            controller: currentCard.translationController,
                            decoration: const InputDecoration(
                              hintText: 'Translation',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 10, bottom: 10),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}