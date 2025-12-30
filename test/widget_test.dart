import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ethiomark8/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen text is present (assuming it starts here)
    // Note: Since we have an AuthWrapper and Firebase initialization, 
    // a simple test might need mocks. For now, we'll just verify the app builds.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
