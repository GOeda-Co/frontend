import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: LoginScreen(),
        routes: {
          '/signup': (context) => Scaffold(body: Text('Sign Up Page')),
        },
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render login screen with all UI elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Verify main UI elements are present
        expect(find.text('Welcome to Repeatro!'), findsOneWidget);
        expect(find.text('Sign in to continue'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Log in'), findsOneWidget);
        expect(find.text('Don\'t have an account?'), findsOneWidget);
        expect(find.text('Sign up'), findsOneWidget);
      });

      testWidgets('should render input fields', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byType(TextField), findsNWidgets(2));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });
    });

    group('User Interaction Tests', () {
      testWidgets('should allow typing in email field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final emailField = find.byType(TextField).first;
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        expect(find.text('test@example.com'), findsOneWidget);
      });

      testWidgets('should allow typing in password field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        expect(find.text('password123'), findsOneWidget);
      });

      testWidgets('should toggle password visibility', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final passwordField = find.byType(TextField).last;
        final visibilityIcon = find.byIcon(Icons.visibility);

        // Initially password should be obscured
        expect(tester.widget<TextField>(passwordField).obscureText, isTrue);

        // Tap visibility toggle
        await tester.tap(visibilityIcon);
        await tester.pump();

        // Password should now be visible
        expect(tester.widget<TextField>(passwordField).obscureText, isFalse);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      });

      testWidgets('should navigate to signup page when signup button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final signupButton = find.text('Sign up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Sign Up Page'), findsOneWidget);
      });
    });

    group('Form Validation Tests', () {
      testWidgets('should handle login button press', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final loginButton = find.text('Log in');
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Should handle the tap without errors
        expect(find.text('Log in'), findsOneWidget);
      });
    });
  });
} 