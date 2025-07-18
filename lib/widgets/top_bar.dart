import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const TopBar({
    super.key,
    required this.title, 
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.headlineSmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: textStyle?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const Spacer(),
          
          // Check if actions exist and are not empty
          if (actions != null && actions!.isNotEmpty) 
              Row(
                children: actions!,
              ),
        ],
      ),
    );
  }
}