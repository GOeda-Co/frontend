import 'package:flutter/material.dart';
import 'package:frontend/app.dart';

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  final List<String> _screenshtPaths = [
    'lib/screenshots/scrn1.png',
    'lib/screenshots/scrn2.png',
    'lib/screenshots/scrn3.png',
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75, initialPage: _currentPage);

    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _scrollToNextImage() {
    if (_currentPage < _screenshtPaths.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to calculate responsive widths
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // Use Theme.of(context).colorScheme for consistency
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant, // Example color
        title: Text(
          'Repeatro',
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).colorScheme.onSurface, // Use onSurface for text on AppBar
          ),
        ),
        toolbarHeight: 65,
        actions: <Widget>[
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode // Show light mode icon if current theme is dark
                : Icons.dark_mode), // Show dark mode icon if current theme is light
            tooltip: 'Switch Theme',
            onPressed: () {
              // Call the callback passed from MyApp to toggle the theme
              currentThemeMode.value = Theme.of(context).brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary
                    foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use theme onPrimary
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary
                    foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use theme onPrimary
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //TODO: Remove this button
                ElevatedButton(onPressed: () {
                  // Make sure your '/app-shell' route is defined in main.dart
                  Navigator.pushNamed(context, '/app-shell');
                }, child: const Text('TEMP:App Shell'))
              ],
            ),
          )
        ],
      ),
      body: Container(
        // Use Theme.of(context).colorScheme for background colors
        color: Theme.of(context).colorScheme.surfaceContainerLowest, // Or appropriate surface color
        // The main content of the body should expand to fill available space
        child: Row( // This Row now fills the Container, which fills the body
          // Align content within the row (horizontally)
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Space out the two columns
          crossAxisAlignment: CrossAxisAlignment.center, // Vertically center content in the row
          children: [
            // Column for the main text
            Expanded( // Allow text column to take available width
              flex: 2, // Give it more flex if you want it wider
              child: Padding(
                padding: const EdgeInsets.only(left: 80), // Removed top padding here, mainAxisAlignment.center handles vertical
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Vertically center text within its expanded space
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      'Remembering is \neasier with',
                      style: TextStyle(
                        fontSize: 80,
                        color: Theme.of(context).colorScheme.onSurfaceVariant, // Use theme color
                        height: 1.0, // Ensure line height is consistent
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Repeatro',
                      style: TextStyle(
                        fontSize: 80,
                        color: Theme.of(context).colorScheme.onSurface, // Use theme color
                        height: 1.0, // Ensure line height is consistent
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40), // Space between text and button
                    ElevatedButton(
                      onPressed: _scrollToNextImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary
                        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use theme onPrimary
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text(
                        'Learn more →',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Column for the image carousel
            Expanded( // Allow carousel column to take available width
              flex: 2, // Adjust flex to balance with text column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center carousel vertically
                crossAxisAlignment: CrossAxisAlignment.end, // Align carousel to the end (right)
                children: [
                  SizedBox(
                    height: 400, // Increased fixed height for the image carousel
                    width: screenWidth * 0.4, // Adjust width to be a portion of screenWidth
                    child: PageView.builder( // Changed to PageView.builder for better control of current page
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _screenshtPaths.length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double scale = 1.0;
                            if (_pageController.hasClients && _pageController.position.haveDimensions) {
                              final currentPageValue = _pageController.page ?? _pageController.initialPage.toDouble();
                              final page = index.toDouble();
                              final pageDelta = (page - currentPageValue).abs();
                              scale = 1 - (pageDelta * 0.1);
                            }
                            return Center(
                              child: Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            // Set width for each item in the PageView
                            width: (screenWidth * 0.4) * _pageController.viewportFraction,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2), // Use withOpacity for clarity
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                _screenshtPaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}