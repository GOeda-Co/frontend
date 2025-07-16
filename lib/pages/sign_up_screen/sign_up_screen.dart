import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/app.dart';
import 'package:frontend/pages/element_colors.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true; // Password visibility
  final TextEditingController _nameTextController =
      TextEditingController(); // Text deletion
  final TextEditingController _emailTextController =
      TextEditingController(); // Text deletion
  final TextEditingController _passwordTextController =
      TextEditingController(); // Text deletion

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Center(
        // Center the entire box horizontally and vertically
        child: Container(
          width: 350, // Specify the desired width of your box
          height: 420, // Specify the desired height of your box
          padding: const EdgeInsets.all(20.0), // Add padding inside the box
          decoration: BoxDecoration(
            color: ElementColors.backgroundColor, // Background color of the box
            borderRadius: BorderRadius.circular(
              ElementColors.borderRadius,
            ), // Rounded corners
          ),
          child: Column(
            // Center the text within the box
            children: [
              Text(
                'Welcome to Repeatro!',
                textAlign:
                    TextAlign.center, // Center the text itself if it wraps
                style: TextStyle(
                  fontSize: 24,
                  color: ElementColors.textColor, // Text color
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameTextController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: ElementColors.hintTextColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      _nameTextController.clear();
                      FocusScope.of(context).requestFocus();
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: ElementColors.hintTextColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      _emailTextController.clear();
                      FocusScope.of(context).requestFocus();
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordTextController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: ElementColors.hintTextColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                        ),

                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () {
                          _passwordTextController.clear();
                          FocusScope.of(context).requestFocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ElementColors.buttonColor, //Button color
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text('Sign Up', style: TextStyle(fontSize: 17)),
                onPressed: () async {
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
                    errorMessage =
                        'Password must be at least 6 characters long.';
                  }

                  if (errorMessage != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text(errorMessage!),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  try {
                    final responseString = ApiService().register(
                      email,
                      password,
                      name,
                    );

                    final json = jsonDecode(responseString.toString());
                    final userId = json['user_id'];
                    final message = json['message'];

                    print(userId);
                    print(message);

                    if (userId != null) {
                      // Navigate or show success
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Success'),
                          content: Text(message ?? 'Account created.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => LoginScreen()),
                                );
                              },
                              child: Text('Continue'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      throw Exception(message ?? "Unknown registration error.");
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              Text('Already have an account?', style: TextStyle(fontSize: 15)),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Login', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
