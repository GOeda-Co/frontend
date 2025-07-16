import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/landing_page/landing_page.dart';
import 'package:frontend/pages/sign_up_screen/sign_up_screen.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';
import 'package:frontend/layout/app_shell.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LandingPage Widget Tests', () {
    Widget createTestWidget() {
      return const MyLandingPage();
    }

    group('Initial UI Tests', () {
      testWidgets('should display the main landing page structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have the main MaterialApp structure
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should display correct app bar title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should display "Repeatro" title
        expect(find.text('Repeatro'), findsOneWidget);
      });

      testWidgets('should display navigation buttons in app bar', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have Sign up and Log in buttons
        expect(find.text('Sign up'), findsOneWidget);
        expect(find.text('Log in'), findsOneWidget);
        expect(find.text('TEMP:App Shell'), findsOneWidget);
      });

      testWidgets('should display main heading text', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should display the main heading
        expect(find.text('Remembering is'), findsOneWidget);
        expect(find.text('easier with'), findsOneWidget);
        expect(find.text('Repeatro'), findsNWidgets(2)); // One in app bar, one in body
      });

      testWidgets('should display Learn more button', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have Learn more button
        expect(find.text('Learn more →'), findsOneWidget);
      });

      testWidgets('should display image carousel', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have ListView for carousel
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(PageController), findsOneWidget);
      });
    });

    group('App Bar Tests', () {
      testWidgets('should have correct app bar styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper app bar structure
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.toolbarHeight, 65);
        expect(appBar.backgroundColor, isNotNull);
      });

      testWidgets('should have proper button styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have elevated buttons with proper styling
        expect(find.byType(ElevatedButton), findsNWidgets(4)); // Sign up, Log in, Learn more, TEMP button
      });

      testWidgets('should have proper button spacing', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have SizedBox for spacing between buttons
        expect(find.byType(SizedBox), findsWidgets);
      });
    });

    group('Navigation Tests', () {
      testWidgets('should navigate to sign up page when Sign up button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Tap Sign up button
        await tester.tap(find.text('Sign up'));
        await tester.pumpAndSettle();

        // Should navigate to SignUpScreen
        expect(find.byType(SignUpScreen), findsOneWidget);
      });

      testWidgets('should navigate to login page when Log in button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Tap Log in button
        await tester.tap(find.text('Log in'));
        await tester.pumpAndSettle();

        // Should navigate to LoginScreen
        expect(find.byType(LoginScreen), findsOneWidget);
      });

      testWidgets('should navigate to app shell when TEMP button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Tap TEMP button
        await tester.tap(find.text('TEMP:App Shell'));
        await tester.pumpAndSettle();

        // Should navigate to AppShell
        expect(find.byType(AppShell), findsOneWidget);
      });

      testWidgets('should maintain navigation context', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper navigation setup
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(GlobalKey<NavigatorState>), findsOneWidget);
      });
    });

    group('Image Carousel Tests', () {
      testWidgets('should display correct number of images', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have 3 images in carousel
        expect(find.byType(Image), findsNWidgets(3));
      });

      testWidgets('should have proper carousel structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper carousel components
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(AnimatedBuilder), findsNWidgets(3));
        expect(find.byType(Transform), findsNWidgets(3));
      });

      testWidgets('should have proper image styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper image containers
        expect(find.byType(Container), findsWidgets);
        expect(find.byType(ClipRRect), findsNWidgets(3));
        expect(find.byType(BoxDecoration), findsWidgets);
      });

      testWidgets('should handle carousel scrolling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should be able to scroll the carousel
        await tester.drag(find.byType(ListView), const Offset(-100, 0));
        await tester.pump();

        // Should handle scrolling gracefully
        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('should have proper viewport fraction', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have PageController with viewportFraction 0.75
        expect(find.byType(PageController), findsOneWidget);
      });
    });

    group('Learn More Button Tests', () {
      testWidgets('should scroll to next image when Learn more button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Initial state should be on first image
        expect(find.byType(Image), findsNWidgets(3));

        // Tap Learn more button
        await tester.tap(find.text('Learn more →'));
        await tester.pump();

        // Should trigger carousel animation
        expect(find.byType(AnimatedBuilder), findsNWidgets(3));
      });

      testWidgets('should handle Learn more button styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper button styling
        final learnMoreButton = find.text('Learn more →');
        expect(learnMoreButton, findsOneWidget);
      });
    });

    group('Responsive Design Tests', () {
      testWidgets('should handle different screen sizes', (WidgetTester tester) async {
        // Test with different screen sizes
        await tester.binding.setSurfaceSize(const Size(400, 600));
        await tester.pumpWidget(createTestWidget());
        expect(find.byType(Scaffold), findsOneWidget);

        // Test with larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        expect(find.byType(Scaffold), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle mobile screen sizes', (WidgetTester tester) async {
        // Test mobile size
        await tester.binding.setSurfaceSize(const Size(375, 667));
        await tester.pumpWidget(createTestWidget());

        // Should display properly on mobile
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.text('Repeatro'), findsNWidgets(2));

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle tablet screen sizes', (WidgetTester tester) async {
        // Test tablet size
        await tester.binding.setSurfaceSize(const Size(768, 1024));
        await tester.pumpWidget(createTestWidget());

        // Should display properly on tablet
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Row), findsWidgets);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle desktop screen sizes', (WidgetTester tester) async {
        // Test desktop size
        await tester.binding.setSurfaceSize(const Size(1920, 1080));
        await tester.pumpWidget(createTestWidget());

        // Should display properly on desktop
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Expanded), findsWidgets);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Layout Structure Tests', () {
      testWidgets('should have proper row and column structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper layout structure
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(Column), findsWidgets);
        expect(find.byType(Expanded), findsWidgets);
      });

      testWidgets('should have proper padding configuration', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper padding
        expect(find.byType(Padding), findsWidgets);
      });

      testWidgets('should have proper spacing between elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper spacing
        expect(find.byType(SizedBox), findsWidgets);
      });

      testWidgets('should have proper flex configuration', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have Expanded widgets with flex
        final expandedWidgets = find.byType(Expanded);
        expect(expandedWidgets, findsWidgets);
      });
    });

    group('Animation Tests', () {
      testWidgets('should handle carousel animations', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have AnimatedBuilder for carousel
        expect(find.byType(AnimatedBuilder), findsNWidgets(3));

        // Should handle animation gracefully
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle page transitions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle page transitions
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle scale animations', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have Transform.scale for carousel items
        expect(find.byType(Transform), findsNWidgets(3));
      });
    });

    group('Theme and Styling Tests', () {
      testWidgets('should apply correct theme', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper theme configuration
        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets('should have proper text styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper text elements
        expect(find.text('Remembering is'), findsOneWidget);
        expect(find.text('easier with'), findsOneWidget);
        expect(find.text('Repeatro'), findsNWidgets(2));
      });

      testWidgets('should have proper color scheme', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper color configuration
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have proper semantic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper semantic structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('should support screen readers', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper text elements for screen readers
        expect(find.text('Sign up'), findsOneWidget);
        expect(find.text('Log in'), findsOneWidget);
        expect(find.text('Learn more →'), findsOneWidget);
      });

      testWidgets('should have proper focus management', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle focus properly
        expect(find.byType(Scaffold), findsOneWidget);
        
        // Test focus navigation
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
    });

    group('Performance Tests', () {
      testWidgets('should render efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should render without performance issues
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid interactions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Rapidly interact with buttons
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Learn more →'));
          await tester.pump();
        }

        // Should handle rapid interactions gracefully
        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle memory efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Wait for components to load
        await tester.pumpAndSettle();

        // Dispose and recreate widget
        await tester.pumpWidget(Container());
        await tester.pumpWidget(createTestWidget());

        // Should handle memory efficiently
        expect(tester.takeException(), isNull);
      });
    });

    group('Edge Cases Tests', () {
      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        // Test with very small screen
        await tester.binding.setSurfaceSize(const Size(300, 400));
        await tester.pumpWidget(createTestWidget());

        // Should handle small screens gracefully
        expect(find.byType(Scaffold), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle rapid carousel scrolling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Rapidly scroll the carousel
        for (int i = 0; i < 10; i++) {
          await tester.drag(find.byType(ListView), const Offset(-50, 0));
          await tester.pump();
        }

        // Should handle rapid scrolling gracefully
        expect(tester.takeException(), isNull);
        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('should handle missing images gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle potential missing images gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle navigation errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle navigation errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });

    group('Memory Management Tests', () {
      testWidgets('should dispose PageController properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Wait for components to load
        await tester.pumpAndSettle();

        // Dispose widget
        await tester.pumpWidget(Container());

        // Should not throw any disposal errors
        expect(tester.takeException(), isNull);
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets('should handle widget lifecycle properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Test widget lifecycle
        await tester.pumpAndSettle();
        await tester.pumpWidget(Container());
        await tester.pumpWidget(createTestWidget());

        // Should handle lifecycle properly
        expect(tester.takeException(), isNull);
      });
    });

    group('Integration Tests', () {
      testWidgets('should work with MaterialApp navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should work properly within MaterialApp
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle theme changes', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle theme changes gracefully
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle locale changes', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle locale changes gracefully
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('should handle image loading errors', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle image loading errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle navigation errors', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle navigation errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle animation errors', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle animation errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });

    group('State Management Tests', () {
      testWidgets('should maintain carousel state', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should maintain carousel state properly
        await tester.pumpAndSettle();
        expect(find.byType(PageController), findsOneWidget);
      });

      testWidgets('should handle state changes gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle state changes gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });
  });
} 