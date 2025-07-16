import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/app.dart';
// import 'package:frontend/pages/element_colors.dart'; // Consider removing this import if no longer needed
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true; // Password visibility
  final TextEditingController _nameTextController = TextEditingController(); // Text deletion
  final TextEditingController _emailTextController = TextEditingController(); // Text deletion
  final TextEditingController _passwordTextController = TextEditingController(); // Text deletion

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Use theme's background color (surface or surfaceContainerLowest also options)
      appBar: AppBar(
        backgroundColor: colorScheme.surface, // Use theme's surface color for AppBar
        iconTheme: IconThemeData(color: colorScheme.onSurface), // Color for leading icons like back button
      ),
      body: Center(
        // Center the entire box horizontally and vertically
        child: Container(
          width: 350, // Specify the desired width of your box
          height: 420, // Specify the desired height of your box
          padding: const EdgeInsets.all(20.0), // Add padding inside the box
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer, // Background color of the box from theme
            borderRadius: BorderRadius.circular(
              15.0, // Using a fixed value, or define in your theme
            ), // Rounded corners
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Welcome to Repeatro!',
                  textAlign: TextAlign.center, // Center the text itself if it wraps
                  style: TextStyle(
                    fontSize: 24,
                    color: colorScheme.onSurface, // Text color on the surface
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameTextController,
                  style: TextStyle(color: colorScheme.onSurface), // Input text color
                  decoration: InputDecoration(
                    hintText: 'Name',
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
                        _nameTextController.clear();
                        FocusScope.of(context).requestFocus();
                      },
                    ),
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
                  child: const Text('Sign Up', style: TextStyle(fontSize: 17)),
                  onPressed: () async { // Make onPressed async to await API call
                    final email = _emailTextController.text.trim();
                    final password = _passwordTextController.text;
                    final name = _nameTextController.text.trim();

                    String? errorMessage;

                    if (name.isEmpty) {
                      errorMessage = 'Name cannot be empty.';
                    } else if (email.isEmpty ||
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                      errorMessage = 'Enter a valid email address.';
                    } else if (password.length < 6) {
                      errorMessage = 'Password must be at least 6 characters long.';
                    }

                    if (errorMessage != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Invalid Input', style: TextStyle(color: colorScheme.onSurface)),
                          content: Text(errorMessage!, style: TextStyle(color: colorScheme.onSurfaceVariant)), // Use ! as checked by if
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
                      // Await the API call
                      final responseString = await ApiService().register(
                        email,
                        password,
                        name,
                      );

                      // Ensure responseString is not null before decoding
                      if (responseString == null || responseString.isEmpty) {
                        throw Exception("Server returned no response or empty response.");
                      }

                      final json = jsonDecode(responseString);
                      final userId = json['user_id'];
                      final message = json['message'];

                      print(userId);
                      print(message);

                      if (userId != null) {
                        // Navigate or show success
                        if (mounted) { // Check mounted before showDialog
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Success', style: TextStyle(color: colorScheme.onSurface)),
                              content: Text(message ?? 'Account created.', style: TextStyle(color: colorScheme.onSurfaceVariant)),
                              backgroundColor: colorScheme.surfaceContainerHigh,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Dismiss dialog
                                    // Use pushReplacementNamed to go to login and remove signup from stack
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                  child: Text('Continue', style: TextStyle(color: colorScheme.primary)),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // If userId is null, it's an error from the API
                        throw Exception(message ?? "Unknown registration error.");
                      }
                    } catch (e) {
                      if (mounted) { // Check mounted before showDialog
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Error', style: TextStyle(color: colorScheme.error)), // Use error color for title
                            content: Text(e.toString(), style: TextStyle(color: colorScheme.onSurfaceVariant)),
                            backgroundColor: colorScheme.surfaceContainerHigh,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK', style: TextStyle(color: colorScheme.primary)),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    // Removed the redundant Navigator.push here, as it's handled in success dialog
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onBackground, // Text color
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
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
      ),
    );
  }
}