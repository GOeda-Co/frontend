import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/app.dart';
// import 'package:frontend/pages/element_colors.dart'; // Remove or comment this out if not needed
import 'package:frontend/sso/storage.dart';
import 'package:frontend/layout/app_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true; // Password visibility
  final TextEditingController _emailTextController = TextEditingController(); // Text deletion
  final TextEditingController _passwordTextController = TextEditingController(); // Text deletion

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the current theme's color scheme
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background, // Use theme's background color for the Scaffold
      appBar: AppBar(
        backgroundColor: colorScheme.surface, // Use theme's surface color for AppBar
        iconTheme: IconThemeData(color: colorScheme.onSurface), // Color for leading icons like back button
      ),
      body: Center(
        // Center the entire box horizontally and vertically
        child: Container(
          width: 350, // Specify the desired width of your box
          height: 370, // Specify the desired height of your box
          padding: const EdgeInsets.all(20.0), // Add padding inside the box
          decoration: BoxDecoration(
            color: colorScheme.surface, // Background color of the box from theme
            borderRadius: BorderRadius.circular(
              15.0, // Using a fixed value, or define in your theme
            ), // Rounded corners
          ),
          child: Column(
            // Center the text within the box
            children: [
              Text(
                'Welcome to Repeatro!',
                textAlign: TextAlign.center, // Center the text itself if it wraps
                style: TextStyle(
                  fontSize: 24,
                  color: colorScheme.onSurface, // Text color on the surface
                ),
              ),
              Text(
                'Log in to continue',
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onSurfaceVariant, // Use a softer text color from theme
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailTextController,
                style: TextStyle(color: colorScheme.onSurface), // Input text color
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant, // Hint text color
                  ),
                  fillColor: colorScheme.surfaceVariant, // Text field background color
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.outline), // Border color
                  ),
                  enabledBorder: OutlineInputBorder( // Ensure border color applies when enabled
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder( // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete, size: 20, color: colorScheme.onSurfaceVariant), // Icon color
                    onPressed: () {
                      _emailTextController.clear();
                      FocusScope.of(context).requestFocus();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordTextController,
                obscureText: _isObscure,
                style: TextStyle(color: colorScheme.onSurface), // Input text color
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant, // Hint text color
                  ),
                  fillColor: colorScheme.surfaceVariant, // Text field background color
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: colorScheme.onSurfaceVariant, // Icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, size: 20, color: colorScheme.onSurfaceVariant), // Icon color
                        onPressed: () {
                          _passwordTextController.clear();
                          FocusScope.of(context).requestFocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary, // Button background color from theme
                  foregroundColor: colorScheme.onPrimary, // Button text/icon color from theme
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text('Log in', style: TextStyle(fontSize: 17)),
                onPressed: () async {
                  final email = _emailTextController.text.trim();
                  final password = _passwordTextController.text;

                  String? errorMessage;

                  if (email.isEmpty ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                    errorMessage = 'Enter a valid email address.';
                  } else if (password.length < 6) {
                    errorMessage = 'Password must be at least 6 characters long.';
                  }

                  if (errorMessage != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Input', style: TextStyle(color: colorScheme.onSurface)), // Theme text color
                        content: Text(errorMessage!, style: TextStyle(color: colorScheme.onSurfaceVariant)), // Theme text color
                        backgroundColor: colorScheme.surfaceContainerHigh, // Dialog background color
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK', style: TextStyle(color: colorScheme.primary)), // Theme button color
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  try {
                    final responseString = await ApiService().login(
                      email,
                      password,
                      1,
                    );

                    if (responseString == null) {
                      throw Exception("Server returned no response.");
                    }

                    final json = jsonDecode(responseString);
                    final token = json['token'];

                    if (token == null || token.isEmpty) {
                      throw Exception("Wrong email or password");
                    }

                    await TokenStorage.saveToken(token);

                    // If login is successful, navigate:
                    Navigator.pushReplacementNamed(
                      context, 
                      '/app-shell',
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Login Failed', style: TextStyle(color: colorScheme.onSurface)), // Theme text color
                        content: Text(e.toString(), style: TextStyle(color: colorScheme.onSurfaceVariant)), // Theme text color
                        backgroundColor: colorScheme.surfaceContainerHigh, // Dialog background color
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK', style: TextStyle(color: colorScheme.primary)), // Theme button color
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onBackground, // Text color
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.primary, // Link text color from theme
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}