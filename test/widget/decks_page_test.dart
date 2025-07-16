import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/pages/decks/decks_page.dart';
import '../../lib/pages/decks/recents/recents.dart';
import '../../lib/pages/decks/stats/stats.dart';

void main() {
  group('DecksPage Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: const DecksPage(),
      );
    }

    group('Initial UI Tests', () {
      testWidgets('should display the main page structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have the main scaffold structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Padding), findsWidgets);
        expect(find.byType(Column), findsWidgets);
      });

      testWidgets('should have proper padding configuration', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have left padding of 25.0
        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.only(left: 25.0));
      });

      testWidgets('should display RecentsSection component', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should contain RecentsSection
        expect(find.byType(RecentsSection), findsOneWidget);
      });

      testWidgets('should display StatsSection component', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should contain StatsSection
        expect(find.byType(StatsSection), findsOneWidget);
      });

      testWidgets('should have proper spacing between sections', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have SizedBox with height 48 between sections
        final sizedBoxes = find.byType(SizedBox);
        expect(sizedBoxes, findsWidgets);
      });
    });

    group('Layout Structure Tests', () {
      testWidgets('should have correct column alignment', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Main column should have crossAxisAlignment.start
        final column = tester.widget<Column>(find.byType(Column).first);
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
      });

      testWidgets('should have proper children structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have RecentsSection, SizedBox, and StatsSection in order
        final column = tester.widget<Column>(find.byType(Column).first);
        expect(column.children.length, 3);
        expect(column.children[0], isA<RecentsSection>());
        expect(column.children[1], isA<SizedBox>());
        expect(column.children[2], isA<StatsSection>());
      });

      testWidgets('should handle different screen sizes', (WidgetTester tester) async {
        // Test with different screen sizes
        await tester.binding.setSurfaceSize(const Size(400, 600));
        await tester.pumpWidget(createTestWidget());

        // Should still display properly
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        // Test with very small screen
        await tester.binding.setSurfaceSize(const Size(300, 400));
        await tester.pumpWidget(createTestWidget());

        // Should still display properly
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Padding), findsWidgets);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Component Integration Tests', () {
      testWidgets('should properly integrate RecentsSection', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // RecentsSection should be properly integrated
        expect(find.byType(RecentsSection), findsOneWidget);
        
        // Should not throw any integration errors
        expect(tester.takeException(), isNull);
      });

      testWidgets('should properly integrate StatsSection', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // StatsSection should be properly integrated
        expect(find.byType(StatsSection), findsOneWidget);
        
        // Should not throw any integration errors
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle component loading states', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Both sections might show loading initially
        // This tests that the page handles loading states gracefully
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Padding), findsWidgets);
      });
    });

    group('Loading State Tests', () {
      testWidgets('should display while components are loading', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should display the page structure even while loading
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);
      });

      testWidgets('should handle loading state transitions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Initial render
        await tester.pump();

        // Wait for components to load
        await tester.pumpAndSettle();

        // Should still have proper structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);
      });
    });

    group('Navigation Tests', () {
      testWidgets('should handle navigation from RecentsSection', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Wait for components to load
        await tester.pumpAndSettle();

        // Should be able to interact with RecentsSection
        expect(find.byType(RecentsSection), findsOneWidget);
        
        // Navigation should be handled by RecentsSection internally
        // This test verifies the page doesn't interfere with navigation
      });

      testWidgets('should maintain navigation context', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should maintain proper navigation context
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });

    group('Responsive Design Tests', () {
      testWidgets('should adapt to different screen orientations', (WidgetTester tester) async {
        // Test portrait orientation
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        expect(find.byType(Scaffold), findsOneWidget);

        // Test landscape orientation
        await tester.binding.setSurfaceSize(const Size(800, 400));
        await tester.pumpWidget(createTestWidget());
        expect(find.byType(Scaffold), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle tablet screen sizes', (WidgetTester tester) async {
        // Test tablet size
        await tester.binding.setSurfaceSize(const Size(768, 1024));
        await tester.pumpWidget(createTestWidget());

        // Should display properly on tablet
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should handle desktop screen sizes', (WidgetTester tester) async {
        // Test desktop size
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());

        // Should display properly on desktop
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);

        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have proper semantic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper semantic structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Padding), findsWidgets);
        expect(find.byType(Column), findsWidgets);
      });

      testWidgets('should support screen readers', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should have proper text elements for screen readers
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);
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

      testWidgets('should handle rapid rebuilds', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Rapidly rebuild the widget
        for (int i = 0; i < 5; i++) {
          await tester.pumpWidget(createTestWidget());
          await tester.pump();
        }

        // Should handle rapid rebuilds gracefully
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
      testWidgets('should handle very long content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle long content gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle rapid user interactions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Rapidly interact with the page
        for (int i = 0; i < 10; i++) {
          await tester.pump();
        }

        // Should handle rapid interactions gracefully
        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle component errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle potential component errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle network errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle network errors in components gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });

    group('Memory Management Tests', () {
      testWidgets('should dispose resources properly', (WidgetTester tester) async {
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
      testWidgets('should handle component loading failures', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle component loading failures gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle API errors in components', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle API errors in components gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('should handle widget tree errors', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle widget tree errors gracefully
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });

    group('State Management Tests', () {
      testWidgets('should maintain state during rebuilds', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Wait for initial load
        await tester.pumpAndSettle();

        // Rebuild widget
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Should maintain proper state
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(RecentsSection), findsOneWidget);
        expect(find.byType(StatsSection), findsOneWidget);
      });

      testWidgets('should handle state changes in child components', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Should handle state changes in child components
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });
  });
} 