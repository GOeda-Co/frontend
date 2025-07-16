import 'package:flutter/material.dart';

class Flashcard {
  final String id;
  final TextEditingController wordController;
  final TextEditingController translationController;

  Flashcard({
    required this.id,
    required this.wordController,
    required this.translationController,
  });
}