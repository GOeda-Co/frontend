import 'package:flutter/material.dart';
import 'package:frontend/pages/profile/profile_page.dart';
import '../pages/decks/decks_page.dart';
import '../pages/cards/presentation/pages/cards_page.dart';
import '../widgets/top_bar.dart';
import '../pages/create_deck/create_deck.dart';
import '../pages/settings_pages/settings_page.dart';

class AppShell extends StatefulWidget {
  final List<String>? titles;
  final List<Widget>? pages;
  final Widget Function()? settingsPageBuilder;

  const AppShell({super.key, this.titles, this.pages, this.settingsPageBuilder});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  List<String> get titles => widget.titles ?? ['Decks', 'Cards', 'Create new Deck', 'Profile', 'Settings'];
  List<Widget> get pages => widget.pages ?? [
    const DecksPage(),
    const CardsPage(),
    CreateDeckPage(),
    const ProfilePage(), // Use ProfilePage instead of ProfileCenter
    widget.settingsPageBuilder != null ? widget.settingsPageBuilder!() : const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final createButton = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        minimumSize: const Size(100, 50),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create Deck button pressed!')),
        );
        setState(() {
          selectedIndex = 0;
        });
      },
      child: Text(
        'Create',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

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
                  onPressed: () {
                    setState(() => selectedIndex = 2);
                  },
                  tooltip: 'Add',
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    setState(() => selectedIndex = 3);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: selectedIndex == 3
                        ? colors.primary
                        : colors.surfaceContainerHighest,
                    child: Tooltip(
                      message: 'Profile',
                      child: Icon(
                        Icons.person,
                        size: 18,
                        color: selectedIndex == 3
                            ? colors.onPrimary
                            : colors.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Tooltip(
                  message: 'Settings',
                  preferBelow: true,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      setState(() => selectedIndex = 4);
                    },
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
                    TopBar(
                      title: titles[selectedIndex],
                      actions: selectedIndex == 2 // If it's the "Create new Deck" page (index 2)
                          ? [createButton]        // Provide the 'Create' button
                          : [],                   // Otherwise, provide an empty list (no actions)
                    ),
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
