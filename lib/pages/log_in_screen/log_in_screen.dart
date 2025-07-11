import 'package:flutter/material.dart';
import 'package:frontend/pages/element_colors.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center( // Center the entire box horizontally and vertically
        child: Container(
          width: 350, // Specify the desired width of your box
          height: 370, // Specify the desired height of your box
          padding: const EdgeInsets.all(20.0), // Add padding inside the box
          decoration: BoxDecoration(
            color: ElementColors.backgroundColor, // Background color of the box
            borderRadius: BorderRadius.circular(ElementColors.borderRadius), // Rounded corners
          ),
          child: Column( // Center the text within the box
            children: [
              Text(
              'Welcome to Repeatro!',
              textAlign: TextAlign.center, // Center the text itself if it wraps
              style: TextStyle(
                fontSize: 24,
                color: ElementColors.textColor, // Text color
                ),
              ),
              Text('Sign in to continue', style: TextStyle(fontSize: 15, color: Colors.grey)),
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
                    icon: const Icon(
                      Icons.delete, 
                      size: 20
                      ),
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
                        icon: const Icon(
                          Icons.delete, 
                          size: 20
                          ),
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
                 child: Text('Log in', style: TextStyle(fontSize: 17)),
                onPressed: () {
                  // TODO: Implement log in logic
                },
              ),
              SizedBox(height: 20),
              Text('Don\'t have an account?', style: TextStyle(fontSize: 15)),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text('Sign up', style: TextStyle(fontSize: 15)),
              ),
            ]
          ),
          
        ),
      ),
    );
  }
}