import 'package:flutter_test/flutter_test.dart';
import 'package:cineflow/main.dart';

void main() {
  testWidgets('CineFlow initial load test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CineFlowApp());

    // Basic verification that the app starts
    expect(find.byType(CineFlowApp), findsOneWidget);
  });
}
