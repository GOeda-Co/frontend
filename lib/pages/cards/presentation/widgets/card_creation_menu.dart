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

  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Load user info on init to get userId
  }

  Future<void> _loadUserInfo() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      if (mounted) {
        // Handle case where token is null (e.g., user not logged in)
        // Perhaps show an error or redirect to login.
        print('⚠️ No token found for card creation.');
      }
      return;
    }

    try {
      final decoded = JwtDecoder.decode(token);
      if (mounted) {
        setState(() {
          userId = decoded['id']?.toString() ?? decoded['sub']?.toString();
        });
      }
    } catch (e) {
      if (mounted) {
        print('❌ Error decoding token for card creation: $e');
        // Handle token decoding error
      }
    }
  }

  void _submit() async {
    final term = _termController.text.trim();
    final def = _definitionController.text.trim();

    _loadUserInfo();

    if (term.isNotEmpty && def.isNotEmpty && userId != null) {
      // ApiService().dio.addCard();
      try {
        await ApiService().addCard(word: term, translation: def); // Await the API call
        widget.onCreate(term, def); // Call the callback after successful API call
        if (mounted) {
          // Show success feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Card "$term" created successfully!',
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          // Show error feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create card: $e',
                  style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter both term and definition, and ensure you are logged in.',
                style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colors.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text('New Card', style: TextStyle(color: colors.onSurface)),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners for input
                  borderSide: BorderSide(color: colors.outline), // Border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.primary, width: 2), // Focused border color
                ),
              ),
              cursorColor: colors.primary, // Cursor color
              style: TextStyle(color: colors.onSurface), // Input text color
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _definitionController,
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Definition',
                labelStyle: TextStyle(color: colors.onSurfaceVariant),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.primary, width: 2),
                ),
              ),
              cursorColor: colors.primary, // Cursor color
              style: TextStyle(color: colors.onSurface), // Input text color
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: colors.onSurface),
          ),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: Icon(Icons.check, color: colors.onPrimary),
          label: Text('Create', style: TextStyle(color: colors.onPrimary)),
          style: FilledButton.styleFrom(
            backgroundColor: colors.primary,
          ),
        ),
      ],
    );
  }
}