import 'package:flutter/material.dart';
import 'package:frontend/sso/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userId;
  String? email;
  String? name;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      print('⚠️ No token found. Check if user is logged in.');
      if (mounted) {
        setState(() {
          // Set to default or empty if no token
          userId = 'N/A';
          email = 'N/A';
          name = 'Guest';
        });
      }
      return;
    }

    try {
      final decoded = JwtDecoder.decode(token);
      print('🔓 Decoded token: $decoded');
      if (mounted) {
        setState(() {
          userId = decoded['id']?.toString() ?? decoded['sub']?.toString() ?? 'N/A';
          email = decoded['email'] ?? 'N/A';
          name = decoded['name'] ?? 'User';
        });
      }
    } catch (e) {
      print('❌ Error decoding token: $e');
      if (mounted) {
        setState(() {
          // Set to default or empty on error
          userId = 'Error';
          email = 'Error';
          name = 'Error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        width: double.infinity,
        height: 550,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: userId == null || email == null || name == null
            ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      CircleAvatar(
                        radius: 140,
                        backgroundColor: colorScheme.surfaceContainerHigh,
                        child: Text(
                          name?[0].toUpperCase() ?? "U",
                          style: const TextStyle(
                            fontSize: 96,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 72,
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(text: 'Hello, '),
                              TextSpan(
                                text: name ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding( // padding around the info lines for better layout
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoLine('ID:', userId!, context), // Assert non-null
                        _infoLine('Email:', email!, context), // Assert non-null
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _infoLine(String label, String value, BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label $value',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface,
            ),
          ),
          Divider(
            color: colorScheme.outlineVariant,
            height: 1,
          ),
        ],
      ),
    );
  }
}
