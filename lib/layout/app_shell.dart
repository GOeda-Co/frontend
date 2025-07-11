import 'package:flutter/material.dart';
import '../pages/decks/decks_page.dart';
import '../pages/stats/stats_page.dart';
import '../widgets/top_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  final List<String> titles = ['Decks', 'Stats'];
  final List<Widget> pages = const [DecksPage(), StatsPage()];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      body: Row(
        children: [
          // NAVIGATION RAIL
          Container(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            margin: const EdgeInsets.all(16),
            child: NavigationRail(
              backgroundColor: Colors.transparent,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() => selectedIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              groupAlignment: 0.0, // центрирует по высоте
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Icon(Icons.diamond, size: 32),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.library_books_outlined),
                  selectedIcon: Icon(Icons.library_books),
                  label: Text('Decks'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.insights_outlined),
                  selectedIcon: Icon(Icons.insights),
                  label: Text('Stats'),
                ),
              ],
              trailing: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                      tooltip: 'Settings',
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: colors.primary,
                          child: Icon(
                            Icons.person,
                            color: colors.onPrimary,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
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
}