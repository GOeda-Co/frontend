import 'package:flutter/material.dart';
import 'package:frontend/pages/sign_up_screen/sign_up_screen.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';
import 'package:frontend/pages/element_colors.dart';
import 'package:frontend/layout/app_shell.dart';
//import 'package:frontend/theme.dart'; //TODO: Return to this theme
//import 'package:frontend/util.dart'; //TODO: Return to this util


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Return to this theme
    //final textTheme = createTextTheme(context, 'Archivo', 'Archivo Black');

    return MaterialApp(
      //TODO: Return to this theme
      // theme: MaterialTheme(textTheme).light(),
      // darkTheme: MaterialTheme(textTheme).dark(),
      // themeMode: ThemeMode.system,
      
      //TODO: Remove this theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ElementColors.buttonColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Repeatro'),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/app-shell': (context) => const AppShell(),
      },
      debugShowCheckedModeBanner: false,
      // Enable URL routing for web
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ElementColors.buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text('Sign up', style: TextStyle(color: Colors.white)), 
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ElementColors.buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text('Log in', style: TextStyle(color: Colors.white)),
                ),
                //TODO: Remove this button
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/app-shell');
                }, child: const Text('TEMP:App Shell'))
              ],
            ),
          )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the home page'),
          ],
        ),
      ),
    );
  }