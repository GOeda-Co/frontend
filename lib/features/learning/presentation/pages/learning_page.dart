import 'package:flutter/material.dart';
import '../../application/learning_controller.dart';
import '../../domain/entities/learning_card.dart';
import '../widgets/learning_card_view.dart';
import '../widgets/answer_buttons.dart';

class LearningPage extends StatefulWidget {
  final List<LearningCard> cards;

  const LearningPage({super.key, required this.cards});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  late final LearningController _controller;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _controller = LearningController(widget.cards);
  }

  void _handleRate(String rating) {
    setState(() {
      _controller.submitAnswer(rating);
      _showBack = false;
    });
  }

  void _handleAgain() {
    setState(() {
      _controller.repeatCard(); // важно: не меняем карту, только скрываем ответ
      _showBack = false;
    });
  }

  void _flipCard() {
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = _controller.currentCard;

    return Scaffold(
      appBar: AppBar(title: const Text('Learning Mode')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: _controller.isFinished
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🎉 All cards completed!'),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Decks'),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_controller.currentIndex + 1} / ${_controller.total}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 350,
                      width: 450,
                      child: LearningCardView(
                        card: card!,
                        showBack: _showBack,
                        onTap: _flipCard,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _showBack
                          ? AnswerButtons(
                              key: const ValueKey('buttons'),
                              onRate: _handleRate,
                              onAgain: _handleAgain,
                            )
                          : const SizedBox(
                              key: ValueKey('hint'),
                              height: 80,
                              child: Center(child: Text('Tap the card to reveal answer')),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}