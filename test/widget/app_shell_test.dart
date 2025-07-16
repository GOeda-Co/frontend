import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/layout/app_shell.dart';
import 'package:frontend/widgets/top_bar.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Dio])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock pages for testing
  final mockTitles = ['Decks', 'Cards', 'Create new Deck', 'Profile'];
  final mockPages = [
    Container(key: Key('DecksPage')), 
    Container(key: Key('CardsPage')),
    Container(key: Key('CreateDeckPage')),
    Container(key: Key('ProfilePage')),
  ];

  group('AppShell Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: AppShell(titles: mockTitles, pages: mockPages),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render AppShell with all UI elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Verify main structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Expanded), findsOneWidget);

        // Verify navigation rail
        expect(find.byType(Container), findsWidgets);
        expect(find.byIcon(Icons.library_books), findsOneWidget);
        expect(find.byIcon(Icons.insights), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);

        // Verify main content area
        expect(find.byType(Material), findsOneWidget);
        expect(find.byType(TopBar), findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);
      });

      testWidgets('should render navigation rail with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final navigationRail = find.byType(Container).first;
        final container = tester.widget<Container>(navigationRail);
        final decoration = container.decoration as BoxDecoration;

        expect(container.margin, equals(EdgeInsets.all(16)));
        expect(decoration.borderRadius, equals(BorderRadius.circular(24)));
      });

      testWidgets('should render main content area with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final material = tester.widget<Material>(find.byType(Material));
        final borderRadius = material.borderRadius as BorderRadius;

        expect(borderRadius.topLeft, equals(Radius.circular(24)));
        expect(borderRadius.topRight, equals(Radius.circular(24)));
        expect(material.clipBehavior, equals(Clip.antiAlias));
      });

      testWidgets('should render all navigation items in correct order', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Check navigation items are present
        expect(find.byIcon(Icons.library_books), findsOneWidget);
        expect(find.byIcon(Icons.insights), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);

        // Check tooltips
        expect(find.byTooltip('Decks'), findsOneWidget);
        expect(find.byTooltip('Cards'), findsOneWidget);
        expect(find.byTooltip('Add'), findsOneWidget);
      });

      testWidgets('should render TopBar with correct title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Decks')); // Default page
      });

      testWidgets('should render profile avatar with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);

        final circleAvatar = tester.widget<CircleAvatar>(avatar);
        expect(circleAvatar.radius, equals(16));
      });
    });

    group('Navigation Tests', () {
      testWidgets('should navigate to Decks page when Decks icon is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final decksIcon = find.byIcon(Icons.library_books);
        await tester.tap(decksIcon);
        await tester.pumpAndSettle();

        // Verify DecksPage is rendered
        expect(find.byKey(Key('DecksPage')), findsOneWidget);
        expect(find.byKey(Key('CardsPage')), findsNothing);
        expect(find.byKey(Key('CreateDeckPage')), findsNothing);
        expect(find.byKey(Key('ProfilePage')), findsNothing);

        // Verify TopBar title
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Decks'));
      });

      testWidgets('should navigate to Cards page when Cards icon is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        // Verify CardsPage is rendered
        expect(find.byKey(Key('DecksPage')), findsNothing);
        expect(find.byKey(Key('CardsPage')), findsOneWidget);
        expect(find.byKey(Key('CreateDeckPage')), findsNothing);
        expect(find.byKey(Key('ProfilePage')), findsNothing);

        // Verify TopBar title
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Cards'));
      });

      testWidgets('should navigate to Create Deck page when Add icon is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Verify CreateDeckPage is rendered
        expect(find.byKey(Key('DecksPage')), findsNothing);
        expect(find.byKey(Key('CardsPage')), findsNothing);
        expect(find.byKey(Key('CreateDeckPage')), findsOneWidget);
        expect(find.byKey(Key('ProfilePage')), findsNothing);

        // Verify TopBar title
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Create new Deck'));
      });

      testWidgets('should navigate to Profile page when Profile avatar is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final profileAvatar = find.byType(CircleAvatar);
        await tester.tap(profileAvatar);
        await tester.pumpAndSettle();

        // Verify ProfilePage is rendered
        expect(find.byKey(Key('DecksPage')), findsNothing);
        expect(find.byKey(Key('CardsPage')), findsNothing);
        expect(find.byKey(Key('CreateDeckPage')), findsNothing);
        expect(find.byKey(Key('ProfilePage')), findsOneWidget);

        // Verify TopBar title
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Profile'));
      });

      testWidgets('should show Create button only on Create Deck page', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Initially on Decks page - no Create button
        expect(find.text('Create'), findsNothing);

        // Navigate to Create Deck page
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Create button should be visible
        expect(find.text('Create'), findsOneWidget);

        // Navigate back to Decks page
        final decksIcon = find.byIcon(Icons.library_books);
        await tester.tap(decksIcon);
        await tester.pumpAndSettle();

        // Create button should be hidden
        expect(find.text('Create'), findsNothing);
      });
    });

    group('State Management Tests', () {
      testWidgets('should maintain selected index state', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Start on Decks page (index 0)
        expect(find.byType(TopBar), findsOneWidget);
        final initialTopBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(initialTopBar.title, equals('Decks'));

        // Navigate to Cards page (index 1)
        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        final cardsTopBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(cardsTopBar.title, equals('Cards'));

        // Navigate to Create Deck page (index 2)
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        final createTopBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(createTopBar.title, equals('Create new Deck'));

        // Navigate to Profile page (index 3)
        final profileAvatar = find.byType(CircleAvatar);
        await tester.tap(profileAvatar);
        await tester.pumpAndSettle();

        final profileTopBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(profileTopBar.title, equals('Profile'));
      });

      testWidgets('should update navigation item colors based on selection', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Initially Decks should be selected (purple)
        final decksIcon = find.byIcon(Icons.library_books);
        final decksIconWidget = tester.widget<Icon>(decksIcon);
        expect(decksIconWidget.color, equals(Colors.purple));

        // Navigate to Cards
        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        // Cards should now be purple, Decks should be pink
        final updatedDecksIcon = tester.widget<Icon>(decksIcon);
        final updatedCardsIcon = tester.widget<Icon>(cardsIcon);
        expect(updatedDecksIcon.color, equals(Colors.pink[150]));
        expect(updatedCardsIcon.color, equals(Colors.purple));
      });

      testWidgets('should update profile avatar colors based on selection', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Initially profile should not be selected
        final profileAvatar = find.byType(CircleAvatar);
        final initialAvatar = tester.widget<CircleAvatar>(profileAvatar);
        expect(initialAvatar.backgroundColor, isNot(equals(Colors.purple)));

        // Navigate to Profile
        await tester.tap(profileAvatar);
        await tester.pumpAndSettle();

        // Profile should now be selected
        final updatedAvatar = tester.widget<CircleAvatar>(profileAvatar);
        expect(updatedAvatar.backgroundColor, equals(Colors.purple));
      });
    });

    group('User Interaction Tests', () {
      testWidgets('should handle Create button press on Create Deck page', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate to Create Deck page
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Tap Create button
        final createButton = find.text('Create');
        await tester.tap(createButton);
        await tester.pumpAndSettle();

        // Should show snackbar
        expect(find.text('Create Deck button pressed!'), findsOneWidget);

        // Should navigate back to Decks page
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Decks'));
      });

      testWidgets('should handle rapid navigation between pages', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Rapidly tap different navigation items
        final decksIcon = find.byIcon(Icons.library_books);
        final cardsIcon = find.byIcon(Icons.insights);
        final addIcon = find.byIcon(Icons.add);

        await tester.tap(decksIcon);
        await tester.pumpAndSettle();
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();
        await tester.tap(addIcon);
        await tester.pumpAndSettle();
        await tester.tap(decksIcon);
        await tester.pumpAndSettle();

        // Should end up on Decks page
        final topBar = tester.widget<TopBar>(find.byType(TopBar));
        expect(topBar.title, equals('Decks'));
      });

      testWidgets('should handle multiple Create button presses', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate to Create Deck page
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Tap Create button multiple times
        final createButton = find.text('Create');
        for (int i = 0; i < 3; i++) {
          await tester.tap(createButton);
          await tester.pumpAndSettle();
        }

        // Should show multiple snackbars
        expect(find.text('Create Deck button pressed!'), findsNWidgets(3));
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have semantic labels for navigation items', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Check tooltips are present
        expect(find.byTooltip('Decks'), findsOneWidget);
        expect(find.byTooltip('Cards'), findsOneWidget);
        expect(find.byTooltip('Add'), findsOneWidget);

        // Check semantic structure
        expect(tester.getSemantics(find.byIcon(Icons.library_books)), isNotNull);
        expect(tester.getSemantics(find.byIcon(Icons.insights)), isNotNull);
        expect(tester.getSemantics(find.byIcon(Icons.add)), isNotNull);
        expect(tester.getSemantics(find.byType(CircleAvatar)), isNotNull);
      });

      testWidgets('should support keyboard navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Test tab navigation
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();
      });
    });

    group('Edge Cases Tests', () {
      testWidgets('should handle widget disposal during navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate to different pages
        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Dispose widget
        await tester.pumpWidget(Container());

        // Should not crash
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid state changes', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final decksIcon = find.byIcon(Icons.library_books);
        final cardsIcon = find.byIcon(Icons.insights);

        // Rapidly toggle between pages
        for (int i = 0; i < 5; i++) {
          await tester.tap(decksIcon);
          await tester.pumpAndSettle();
          await tester.tap(cardsIcon);
          await tester.pumpAndSettle();
        }

        // Should not crash
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle theme changes', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Change theme
        await tester.pumpWidget(
          MaterialApp(
            home: AppShell(titles: mockTitles, pages: mockPages),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Should render without errors
        expect(find.byType(AppShell), findsOneWidget);
      });

      testWidgets('should handle different screen sizes', (WidgetTester tester) async {
        // Test with small screen
        tester.binding.window.physicalSizeTestValue = const Size(400, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.byType(AppShell), findsOneWidget);

        // Test with large screen
        tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.byType(AppShell), findsOneWidget);

        // Reset
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });

    group('Memory Management Tests', () {
      testWidgets('should dispose resources properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate through all pages
        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        final profileAvatar = find.byType(CircleAvatar);
        await tester.tap(profileAvatar);
        await tester.pumpAndSettle();

        // Dispose widget
        await tester.pumpWidget(Container());

        // No memory leaks should occur
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle widget disposal during button press', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate to Create Deck page
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        // Start pressing Create button
        final createButton = find.text('Create');
        await tester.tap(createButton);
        await tester.pump();

        // Dispose widget during button press
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();

        // Should not crash
        expect(tester.takeException(), isNull);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('should handle navigation errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Try to navigate to different pages
        final cardsIcon = find.byIcon(Icons.insights);
        await tester.tap(cardsIcon);
        await tester.pumpAndSettle();

        // Should handle gracefully
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle theme errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Test with invalid theme
        await tester.pumpWidget(
          MaterialApp(
            home: AppShell(titles: mockTitles, pages: mockPages),
            theme: ThemeData(), // Minimal theme
          ),
        );
        await tester.pumpAndSettle();

        // Should render without errors
        expect(find.byType(AppShell), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should render quickly', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        stopwatch.stop();
        
        // Should render in reasonable time (less than 500ms due to API calls)
        expect(stopwatch.elapsedMilliseconds, lessThan(500));
      });

      testWidgets('should handle rapid navigation efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final decksIcon = find.byIcon(Icons.library_books);
        final cardsIcon = find.byIcon(Icons.insights);

        // Rapidly navigate between pages
        for (int i = 0; i < 5; i++) {
          await tester.tap(decksIcon);
          await tester.pumpAndSettle();
          await tester.tap(cardsIcon);
          await tester.pumpAndSettle();
        }

        // Should not cause performance issues
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid button presses efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Navigate to Create Deck page
        final addIcon = find.byIcon(Icons.add);
        await tester.tap(addIcon);
        await tester.pumpAndSettle();

        final createButton = find.text('Create');
        expect(createButton, findsOneWidget);

        // Rapidly press Create button
        for (int i = 0; i < 3; i++) {
          await tester.tap(createButton);
          await tester.pumpAndSettle();
        }

        // Should not cause performance issues
        expect(tester.takeException(), isNull);
      });
    });

    group('Integration Tests', () {
      testWidgets('should integrate with MaterialApp navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Test that the widget works within MaterialApp
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(AppShell), findsOneWidget);
      });

      testWidgets('should handle theme changes from parent', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Verify theme integration
        expect(find.byType(AppShell), findsOneWidget);
      });

      testWidgets('should handle locale changes', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppShell(titles: mockTitles, pages: mockPages),
            locale: const Locale('en', 'US'),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(AppShell), findsOneWidget);
      });
    });
  });
} 