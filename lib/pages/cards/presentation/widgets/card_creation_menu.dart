import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/sso/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CardCreationMenu extends StatefulWidget {
  final void Function(String term, String definition) onCreate;

  const CardCreationMenu({super.key, required this.onCreate});

  @override
  State<CardCreationMenu> createState() => _CardCreationMenuState();
}

class _CardCreationMenuState extends State<CardCreationMenu> {
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  String? userId;

  Future<void> _loadUserInfo() async {
    final token = await TokenStorage.getToken();
    if (token == null) return;

    final decoded = JwtDecoder.decode(token);

    setState(() {
      userId = decoded['id']?.toString() ?? decoded['sub']?.toString();
    });
  }

  void _submit() {
    final term = _termController.text.trim();
    final def = _definitionController.text.trim();

    _loadUserInfo();

    if (term.isNotEmpty && def.isNotEmpty) {
      // ApiService().dio.addCard();
      ApiService().addCard(word: term, translation: def);
      widget.onCreate(term, def);
      Navigator.of(context).pop(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text('New Card'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _termController,
              decoration: InputDecoration(
                labelText: 'Term',
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _definitionController,
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Definition',
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.check),
          label: const Text('Create'),
        ),
      ],
    );
  }
}