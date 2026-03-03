import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cineflow/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end test: verify app starts and can navigate to search', (
    WidgetTester tester,
  ) async {
    // Start the app using the actual main function to ensure all services (like Hive) initialize
    app.main();
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    ); // Give it time to initialize

    // Verify the CineFlow interface loaded
    expect(find.byType(CustomScrollView), findsWidgets);

    // Verify SEARCH icon is present and tap it
    final searchIcon = find.byIcon(Icons.search);
    expect(searchIcon, findsOneWidget);

    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    // Verify Search Screen is displayed by looking for a TextField
    expect(find.byType(TextField), findsOneWidget);

    // Go back using the OS back button or AppBar back button (if available)
    final backButton = find.byTooltip(
      'Back',
    ); // Default flutter tooltip for BackButton
    if (backButton.evaluate().isNotEmpty) {
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    }
  });
}
