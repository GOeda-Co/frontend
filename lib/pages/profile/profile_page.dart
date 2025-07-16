import 'package:flutter/material.dart';
import 'package:frontend/sso/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileCenter extends StatefulWidget {
  const ProfileCenter({super.key});

  @override
  State<ProfileCenter> createState() => _ProfileCenterState();
}

class _ProfileCenterState extends State<ProfileCenter> {
  String? userId;
  String? email;
  String? name = "BRO";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      print('⚠️ No token found. Check if user is logged in.');
      return;
    }

    final decoded = JwtDecoder.decode(token);
    print('🔓 Decoded token: $decoded');

    setState(() {
      userId = decoded['id']?.toString() ?? decoded['sub']?.toString();
      email = decoded['email'];
      name = decoded['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        width: double.infinity,
        height: 550,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: userId == null || email == null || name == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 16),
                      CircleAvatar(
                        radius: 140,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          name?[0].toUpperCase() ?? "U",
                          style: const TextStyle(
                            fontSize: 96,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 72,
                              color: Theme.of(context).colorScheme.onSurface,
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
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoLine('ID:', userId!, context),
                      _infoLine('Email:', email!, context),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _infoLine(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label $value',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
