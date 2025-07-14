import 'package:flutter/material.dart';
import 'layout/app_shell.dart';
import 'colorscheme/theme.dart';
import 'colorscheme/util.dart';

class AnkiApp extends StatelessWidget {
  const AnkiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'Archivo', 'Archivo Black');

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: MaterialTheme(textTheme).light(),
      darkTheme: MaterialTheme(textTheme).dark(),
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}