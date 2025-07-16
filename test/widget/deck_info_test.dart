import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/deck_info/deck_info.dart';

void main() {
  group('FlashcardPage Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: FlashcardPage(deckId: 'test-deck-id', deckName: 'Test Deck'),
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render deck info page with basic elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Verify main UI elements are present
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Study'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
      });

      testWidgets('should show loading state initially', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should show some loading indicator or empty state
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('User Interaction Tests', () {
      testWidgets('should handle study button tap', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final studyButton = find.text('Study');
        await tester.tap(studyButton);
        await tester.pump();

        // Should handle the tap without errors
        expect(find.text('Study'), findsOneWidget);
      });

      testWidgets('should handle delete button tap', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final deleteButton = find.text('Delete');
        await tester.tap(deleteButton);
        await tester.pump();

        // Should handle the tap without errors
        expect(find.text('Delete'), findsOneWidget);
      });
    });

    group('Navigation Tests', () {
      testWidgets('should have proper app bar', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar, isNotNull);
      });
    });
  });
} 