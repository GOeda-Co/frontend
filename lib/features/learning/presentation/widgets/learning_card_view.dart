import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../domain/entities/learning_card.dart';

class LearningCardView extends StatefulWidget {
  final LearningCard card;
  final bool showBack;
  final VoidCallback onTap;

  const LearningCardView({
    super.key,
    required this.card,
    required this.showBack,
    required this.onTap,
  });

  @override
  State<LearningCardView> createState() => _LearningCardViewState();
}

class _LearningCardViewState extends State<LearningCardView> {
  Widget _buildCard(BuildContext context, String text, {Key? key}) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      key: key,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.center,
        maxLines: 5,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colors.onSurface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.showBack ? widget.card.back : widget.card.front;

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 220,
        height: 180,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _buildCard(context, text, key: ValueKey(text)),
        ),
      ),
    );
  }
}