import 'package:flutter/material.dart';
import 'layout/app_shell.dart';
import 'colorscheme/theme.dart';
import 'colorscheme/util.dart';
import 'package:frontend/pages/settings_pages/settings_page.dart';
import 'package:frontend/pages/sign_up_screen/sign_up_screen.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';
import 'package:frontend/pages/landing_page/landing_page.dart';
import 'package:frontend/pages/profile/profile_page.dart';

ValueNotifier<ThemeMode> currentThemeMode = ValueNotifier(ThemeMode.light);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// Removed currentSelectedIndex

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Only listen to theme mode changes
    currentThemeMode.addListener(_rebuildApp);
  }

  void _logout() {
    //TODO: Implement logout logic
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    currentThemeMode.removeListener(_rebuildApp);
    super.dispose();
  }

  void _rebuildApp() {
    setState(() {});
  }
 
  // Function to toggle the theme mode
  void _toggleTheme() {
    currentThemeMode.value = currentThemeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'Itim', 'Itim');
    return MaterialApp(
      theme: MaterialTheme(textTheme).light(),
      darkTheme: MaterialTheme(textTheme).dark(),
      themeMode: currentThemeMode.value,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyLandingPage(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfilePage(),
        '/app-shell': (context) => AppShell(
          settingsPageBuilder: () => SettingsPage(
            onToggleTheme: _toggleTheme,
            onLogout: _logout,
          ),
        ),
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}