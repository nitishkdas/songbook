import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:songbook/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Performance Tests', () {
    testWidgets('Scrolling performance on Home Page song list',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate from Songbook Selection to Home Page
      final songbookCard = find.text('Boroni Rwjabnai ni Bijab');
      expect(songbookCard, findsWidgets);
      await tester.tap(songbookCard.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify we are on the Home Page with songs loaded
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      // Measure scroll performance with a stopwatch
      final scrollStopwatch = Stopwatch()..start();

      // Perform multiple fast scroll gestures down
      for (int i = 0; i < 5; i++) {
        await tester.fling(listView, const Offset(0, -500), 1500);
        await tester.pumpAndSettle();
      }

      // Scroll back up
      for (int i = 0; i < 5; i++) {
        await tester.fling(listView, const Offset(0, 500), 1500);
        await tester.pumpAndSettle();
      }

      scrollStopwatch.stop();
      debugPrint('=== PERFORMANCE RESULTS ===');
      debugPrint('Scroll test (10 flings): ${scrollStopwatch.elapsedMilliseconds}ms');
      debugPrint('Average per fling: ${scrollStopwatch.elapsedMilliseconds / 10}ms');
    });

    testWidgets('Filter switching performance',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to Home Page
      final songbookCard = find.text('Boroni Rwjabnai ni Bijab');
      expect(songbookCard, findsWidgets);
      await tester.tap(songbookCard.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Record filter switching performance
      final filterStopwatch = Stopwatch()..start();

      final allChars = ['A', 'B', 'G', 'K', 'S', 'T', 'All'];
      for (final char in allChars) {
        final chipFinder = find.text(char);
        if (chipFinder.evaluate().isNotEmpty) {
          await tester.tap(chipFinder.first);
          await tester.pumpAndSettle();
        }
      }

      filterStopwatch.stop();
      debugPrint('=== PERFORMANCE RESULTS ===');
      debugPrint('Filter switching (${allChars.length} filters): ${filterStopwatch.elapsedMilliseconds}ms');
      debugPrint('Average per filter: ${filterStopwatch.elapsedMilliseconds / allChars.length}ms');
    });

    testWidgets('Song detail navigation round-trip',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to Home Page
      final songbookCard = find.text('Boroni Rwjabnai ni Bijab');
      expect(songbookCard, findsWidgets);
      await tester.tap(songbookCard.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final navStopwatch = Stopwatch()..start();

      // Find and tap the first song card
      final songCards = find.byType(InkWell);
      expect(songCards, findsWidgets);
      await tester.tap(songCards.first);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final forwardTime = navStopwatch.elapsedMilliseconds;
      debugPrint('=== PERFORMANCE RESULTS ===');
      debugPrint('Navigate to detail: ${forwardTime}ms');

      // Navigate back using system back
      final backButtons = find.byTooltip('Back');
      if (backButtons.evaluate().isNotEmpty) {
        await tester.tap(backButtons.first);
      } else {
        // Try finding any back arrow icon
        final iconButtons = find.byIcon(Icons.arrow_back);
        if (iconButtons.evaluate().isNotEmpty) {
          await tester.tap(iconButtons.first);
        }
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      navStopwatch.stop();
      debugPrint('Full round-trip navigation: ${navStopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('App startup and database load time',
        (WidgetTester tester) async {
      final startupStopwatch = Stopwatch()..start();

      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      startupStopwatch.stop();
      debugPrint('=== PERFORMANCE RESULTS ===');
      debugPrint('App startup + initial settle: ${startupStopwatch.elapsedMilliseconds}ms');

      // Navigate to home and measure DB load
      final dbStopwatch = Stopwatch()..start();
      final songbookCard = find.text('Boroni Rwjabnai ni Bijab');
      expect(songbookCard, findsWidgets);
      await tester.tap(songbookCard.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      dbStopwatch.stop();
      debugPrint('Home page load (DB + render): ${dbStopwatch.elapsedMilliseconds}ms');

      // Verify all songs loaded
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
    });
  });
}
