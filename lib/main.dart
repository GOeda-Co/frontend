import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized(); // VERY important
  runApp(const MyApp());
}