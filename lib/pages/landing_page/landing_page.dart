import 'package:flutter/material.dart';
import 'package:frontend/pages/sign_up_screen/sign_up_screen.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';
import 'package:frontend/pages/element_colors.dart';
import 'package:frontend/layout/app_shell.dart';
import 'package:frontend/colorscheme/theme.dart';
import 'package:frontend/colorscheme/util.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'Itim', 'Itim');

    return MaterialApp(
      theme: MaterialTheme(textTheme).light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyLandingPage(title: 'Repeatro'),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/app-shell': (context) => const AppShell(),
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key, required this.title});

  final String title;

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
    // Using a smaller viewportFraction to show more of the previous/next image if needed
    // You might want to adjust this based on the actual image size and desired peek.
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
        backgroundColor: ElementColors.appBarColor,
        title: Text(widget.title, style: const TextStyle(fontSize: 40, color: ElementColors.textColor)),
        toolbarHeight: 65,
        actions: <Widget>[
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
                    backgroundColor: ElementColors.buttonColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ElementColors.buttonColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                //TODO: Remove this button
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/app-shell');
                }, child: const Text('TEMP:App Shell'))
              ],
            ),
          )
        ],
      ),
      body: Container(
        color: ElementColors.backgroundColorForLandingPage,
        // The main content of the body should expand to fill available space
        child: Expanded( // <--- Wrap the Row in Expanded to make it fill vertical space
          child: Row(
            // Align content within the row (horizontally)
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Space out the two columns
            crossAxisAlignment: CrossAxisAlignment.center, // Vertically center content in the row
            children: [
              // Column for the main text
              Expanded( // <--- Allow text column to take available width
                flex: 2, // Give it more flex if you want it wider
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, top: 0), // Adjust top padding as needed, or remove it and use alignment
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Vertically center text within its expanded space
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        'Remembering is \neasier with',
                        style: const TextStyle(
                          fontSize: 80,
                          color: ElementColors.textColor2,
                          height: 1.0, // Ensure line height is consistent
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Repeatro',
                        style: const TextStyle(
                          fontSize: 80,
                          color: ElementColors.textColor,
                          height: 1.0, // Ensure line height is consistent
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 40), // Space between text and button
                      ElevatedButton(
                        onPressed: _scrollToNextImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ElementColors.buttonColor,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text(
                          'Learn more →',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Column for the image carousel
              Expanded( // <--- Allow carousel column to take available width
                flex: 2, // Adjust flex to balance with text column
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center carousel vertically
                  crossAxisAlignment: CrossAxisAlignment.end, // Center carousel horizontally in its space
                  children: [
                    SizedBox(
                      height: 400, // Increased fixed height for the image carousel
                      width: screenWidth * 0.4, // Adjust width to be a portion of screenWidth
                      child: ListView.builder(
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
                              // Set width relative to the Sizedbox's width
                              width: (screenWidth * 0.4) * _pageController.viewportFraction, // Use viewportFraction to calculate item width
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(51),
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
      ),
    );
  }
}