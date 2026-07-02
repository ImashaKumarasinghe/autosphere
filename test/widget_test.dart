import 'package:flutter_test/flutter_test.dart';
import 'package:autosphere/main.dart';

void main() {
  testWidgets('Smoke test - Verify AutoSphereApp loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AutoSphereApp());

    // Verify that the title "AutoSphere" is present in the widget tree
    expect(find.text('AutoSphere'), findsWidgets);
  });
}
