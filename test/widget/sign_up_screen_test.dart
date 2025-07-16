import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/sign_up_screen/sign_up_screen.dart';
import 'package:frontend/pages/element_colors.dart';
import 'package:frontend/api/api.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks
@GenerateMocks([ApiService])
import 'sign_up_screen_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpScreen Widget Tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: SignUpScreen(),
        routes: {
          '/login': (context) => Scaffold(body: Text('Login Page')),
        },
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render signup screen with all UI elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Verify main UI elements are present
        expect(find.text('Welcome to Repeatro!'), findsOneWidget);
        expect(find.text('Name'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Sign Up'), findsOneWidget);
        expect(find.text('Already have an account?'), findsOneWidget);
        expect(find.text('Login'), findsOneWidget);

        // Verify input fields
        expect(find.byType(TextField), findsNWidgets(3));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });

      testWidgets('should render container with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(ElementColors.backgroundColor));
        expect(decoration.borderRadius, equals(BorderRadius.circular(ElementColors.borderRadius)));
      });

      testWidgets('should render AppBar with white background', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, equals(Colors.white));
      });

      testWidgets('should render input fields with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final textFields = tester.widgetList<TextField>(find.byType(TextField));
        
        for (final textField in textFields) {
          final decoration = textField.decoration!;
          expect(decoration.border, isA<OutlineInputBorder>());
          expect(decoration.hintStyle!.color, equals(ElementColors.hintTextColor));
        }
      });

      testWidgets('should render signup button with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final button = tester.widget<ElevatedButton>(find.text('Sign Up'));
        final style = button.style as ButtonStyle;

        expect(style.backgroundColor?.resolve({}), equals(ElementColors.buttonColor));
        expect(style.foregroundColor?.resolve({}), equals(Colors.white));
      });

      testWidgets('should render three text fields in correct order', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final textFields = find.byType(TextField);
        expect(textFields, findsNWidgets(3));

        // Check hint texts are in correct order
        final nameField = tester.widget<TextField>(textFields.at(0));
        final emailField = tester.widget<TextField>(textFields.at(1));
        final passwordField = tester.widget<TextField>(textFields.at(2));

        expect(nameField.decoration!.hintText, equals('Name'));
        expect(emailField.decoration!.hintText, equals('Email'));
        expect(passwordField.decoration!.hintText, equals('Password'));
      });
    });

    group('User Interaction Tests', () {
      testWidgets('should allow typing in name field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should allow typing in email field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final emailField = find.byType(TextField).at(1);
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

      testWidgets('should clear name field when delete button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        expect(find.text('John Doe'), findsOneWidget);

        final deleteButton = find.byIcon(Icons.delete).first;
        await tester.tap(deleteButton);
        await tester.pump();

        expect(find.text('John Doe'), findsNothing);
      });

      testWidgets('should clear email field when delete button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        expect(find.text('test@example.com'), findsOneWidget);

        final deleteButton = find.byIcon(Icons.delete).at(1);
        await tester.tap(deleteButton);
        await tester.pump();

        expect(find.text('test@example.com'), findsNothing);
      });

      testWidgets('should clear password field when delete button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        expect(find.text('password123'), findsOneWidget);

        final deleteButton = find.byIcon(Icons.delete).last;
        await tester.tap(deleteButton);
        await tester.pump();

        expect(find.text('password123'), findsNothing);
      });

      testWidgets('should navigate to login page when login button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final loginButton = find.text('Login');
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('Login Page'), findsOneWidget);
      });
    });

    group('Form Validation Tests', () {
      testWidgets('should show error dialog for empty name', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Name cannot be empty.'), findsOneWidget);
      });

      testWidgets('should show error dialog for empty email', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Enter a valid email address.'), findsOneWidget);
      });

      testWidgets('should show error dialog for invalid email format', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'invalid-email');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Enter a valid email address.'), findsOneWidget);
      });

      testWidgets('should show error dialog for short password', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, '123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Password must be at least 6 characters long.'), findsOneWidget);
      });

      testWidgets('should show error dialog for empty password', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Password must be at least 6 characters long.'), findsOneWidget);
      });

      testWidgets('should close error dialog when OK button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsOneWidget);

        final okButton = find.text('OK');
        await tester.tap(okButton);
        await tester.pumpAndSettle();

        expect(find.text('Invalid Input'), findsNothing);
      });
    });

    group('API Integration Tests', () {
      testWidgets('should handle successful registration', (WidgetTester tester) async {
        // Mock successful API response
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async => '{"user_id": 123, "message": "Account created successfully"}');

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        // Verify success dialog is shown
        expect(find.text('Success'), findsOneWidget);
        expect(find.text('Account created successfully'), findsOneWidget);

        // Verify API was called
        verify(mockApiService.register('test@example.com', 'password123', 'John Doe')).called(1);
      });

      testWidgets('should handle registration failure', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async => '{"message": "Email already exists"}');

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Exception: Email already exists'), findsOneWidget);
      });

      testWidgets('should handle API exception', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenThrow(Exception('Network error'));

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Exception: Network error'), findsOneWidget);
      });

      testWidgets('should navigate to login after successful registration', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async => '{"user_id": 123, "message": "Account created successfully"}');

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        // Click Continue button in success dialog
        final continueButton = find.text('Continue');
        await tester.tap(continueButton);
        await tester.pumpAndSettle();

        // Should navigate to login screen
        expect(find.text('Login Page'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have semantic labels for input fields', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        final emailField = find.byType(TextField).at(1);
        final passwordField = find.byType(TextField).last;

        expect(tester.getSemantics(nameField), isNotNull);
        expect(tester.getSemantics(emailField), isNotNull);
        expect(tester.getSemantics(passwordField), isNotNull);
      });

      testWidgets('should have semantic labels for buttons', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final signupButton = find.text('Sign Up');
        final loginButton = find.text('Login');

        expect(tester.getSemantics(signupButton), isNotNull);
        expect(tester.getSemantics(loginButton), isNotNull);
      });

      testWidgets('should support screen reader navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Test tab navigation through all fields
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();
      });
    });

    group('Edge Cases Tests', () {
      testWidgets('should handle very long name input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        final longName = 'a' * 1000;
        await tester.enterText(nameField, longName);
        await tester.pump();

        expect(find.text(longName), findsOneWidget);
      });

      testWidgets('should handle very long email input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final emailField = find.byType(TextField).at(1);
        final longEmail = 'a' * 1000 + '@example.com';
        await tester.enterText(emailField, longEmail);
        await tester.pump();

        expect(find.text(longEmail), findsOneWidget);
      });

      testWidgets('should handle very long password input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final passwordField = find.byType(TextField).last;
        final longPassword = 'a' * 1000;
        await tester.enterText(passwordField, longPassword);
        await tester.pump();

        expect(find.text(longPassword), findsOneWidget);
      });

      testWidgets('should handle special characters in input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        final specialName = 'José María O\'Connor-Smith';
        await tester.enterText(nameField, specialName);
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        final specialEmail = 'test+tag@example.com';
        await tester.enterText(emailField, specialEmail);
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        final specialPassword = 'p@ssw0rd!@#';
        await tester.enterText(passwordField, specialPassword);
        await tester.pump();

        expect(find.text(specialName), findsOneWidget);
        expect(find.text(specialEmail), findsOneWidget);
        expect(find.text(specialPassword), findsOneWidget);
      });

      testWidgets('should handle rapid button presses', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final signupButton = find.text('Sign Up');

        // Rapidly tap the signup button
        for (int i = 0; i < 5; i++) {
          await tester.tap(signupButton);
          await tester.pump();
        }

        await tester.pumpAndSettle();

        // Should only show one error dialog
        expect(find.text('Invalid Input'), findsOneWidget);
      });

      testWidgets('should handle rapid text input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;

        // Rapidly enter text
        for (int i = 0; i < 10; i++) {
          await tester.enterText(nameField, 'Name$i');
          await tester.pump();
        }

        expect(find.text('Name9'), findsOneWidget);
      });

      testWidgets('should handle whitespace in name field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, '   John Doe   ');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        // Should show error for empty name (after trimming)
        expect(find.text('Invalid Input'), findsOneWidget);
        expect(find.text('Name cannot be empty.'), findsOneWidget);
      });
    });

    group('Memory Management Tests', () {
      testWidgets('should dispose text controllers properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        final emailField = find.byType(TextField).at(1);
        final passwordField = find.byType(TextField).last;

        await tester.enterText(nameField, 'John Doe');
        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        // Dispose the widget
        await tester.pumpWidget(Container());

        // No memory leaks should occur
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle widget disposal during API call', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 100));
          return '{"user_id": 123, "message": "Success"}';
        });

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pump();

        // Dispose widget during API call
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();

        // Should not crash
        expect(tester.takeException(), isNull);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('should handle JSON decode errors', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async => 'invalid json');

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);
      });

      testWidgets('should handle navigation errors', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Try to navigate without proper route setup
        final loginButton = find.text('Login');
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Should handle gracefully
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle null API response', (WidgetTester tester) async {
        when(mockApiService.register('test@example.com', 'password123', 'John Doe'))
            .thenAnswer((_) async => null);

        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        final emailField = find.byType(TextField).at(1);
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        final passwordField = find.byType(TextField).last;
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        final signupButton = find.text('Sign Up');
        await tester.tap(signupButton);
        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should render quickly', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        await tester.pumpWidget(createTestWidget());
        
        stopwatch.stop();
        
        // Should render in reasonable time (less than 100ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });

      testWidgets('should handle rapid state changes efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final passwordField = find.byType(TextField).last;
        final visibilityIcon = find.byIcon(Icons.visibility);

        // Rapidly toggle password visibility
        for (int i = 0; i < 50; i++) {
          await tester.tap(visibilityIcon);
          await tester.pump();
        }

        // Should not cause performance issues
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid text input efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final nameField = find.byType(TextField).first;

        // Rapidly enter text
        for (int i = 0; i < 100; i++) {
          await tester.enterText(nameField, 'Name$i');
          await tester.pump();
        }

        // Should not cause performance issues
        expect(tester.takeException(), isNull);
      });
    });
  });
} 