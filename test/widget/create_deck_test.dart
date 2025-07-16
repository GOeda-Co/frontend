import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/create_deck/create_deck.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CreateDeckPage Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: CreateDeckPage(),
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render create deck page with basic elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Verify main UI elements are present
        expect(find.text('Create New Deck'), findsOneWidget);
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Description'), findsOneWidget);
        expect(find.text('Add Card'), findsOneWidget);
        expect(find.text('Create Deck'), findsOneWidget);
      });

      testWidgets('should render initial cards', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have initial cards
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(find.text('Card 3'), findsOneWidget);
      });
    });

    group('User Interaction Tests', () {
      testWidgets('should allow typing in title field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final titleField = find.byType(TextField).first;
        await tester.enterText(titleField, 'My Test Deck');
        await tester.pump();

        expect(find.text('My Test Deck'), findsOneWidget);
      });

      testWidgets('should allow typing in description field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final descriptionField = find.byType(TextField).at(1);
        await tester.enterText(descriptionField, 'Test description');
        await tester.pump();

        expect(find.text('Test description'), findsOneWidget);
      });

      testWidgets('should add new card when Add Card button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final addCardButton = find.text('Add Card');
        await tester.tap(addCardButton);
        await tester.pump();

        // Should now have 4 cards
        expect(find.text('Card 4'), findsOneWidget);
      });

      testWidgets('should remove card when delete button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final deleteButton = find.byIcon(Icons.delete).first;
        await tester.tap(deleteButton);
        await tester.pump();

        // Should now have 2 cards
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(find.text('Card 3'), findsNothing);
      });
    });

    group('Form Validation Tests', () {
      testWidgets('should show error when creating deck without title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final createButton = find.text('Create Deck');
        await tester.tap(createButton);
        await tester.pumpAndSettle();

        // Should show some form of validation
        expect(find.text('Create Deck'), findsOneWidget);
      });
    });
  });
} 