import 'package:flutter/material.dart';
import 'package:frontend/pages/profile/profile_page.dart';
import '../pages/decks/decks_page.dart';
import '../pages/cards/presentation/pages/cards_page.dart';
import '../widgets/top_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  final List<String> titles = ['Decks', 'Cards', 'Profile'];
  final List<Widget> pages = const [DecksPage(), CardsPage(), ProfileCenter()];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      body: Row(
        children: [
          // NAVIGATION RAIL
          Container(
            width: 72,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                // Верхние кнопки
                const SizedBox(height: 16),
                _buildNavItem(0, Icons.library_books, 'Decks'),
                _buildNavItem(1, Icons.insights, 'Cards'),

                Spacer(), // Отделяет верх от низа
                // Нижние кнопки
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  tooltip: 'Add',
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    setState(() => selectedIndex = 2);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: selectedIndex == 2
                        ? colors.primary
                        : colors.surfaceContainerHighest,
                    child: Icon(
                      Icons.person,
                      size: 18,
                      color: selectedIndex == 2
                          ? colors.onPrimary
                          : colors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, bottom: 0),
              child: Material(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    TopBar(title: titles[selectedIndex]),
                    const Divider(height: 1),
                    Expanded(child: pages[selectedIndex]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNavItem(int index, IconData icon, String tooltip) {
  final isSelected = selectedIndex == index;

  return IconButton(
    icon: Icon(icon, color: isSelected ? Colors.purple : Colors.pink[150]),
    tooltip: tooltip,
    onPressed: () => setState(() => selectedIndex = index),
  );
}
}
