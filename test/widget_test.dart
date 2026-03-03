import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_test/hive_test.dart';
import 'package:cineflow/main.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  testWidgets('CineFlow initial load test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: CineFlowApp()));

    // Basic verification that the app starts
    expect(find.byType(CineFlowApp), findsOneWidget);
  });
}
