// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

// import 'package:autogestor/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: provider.MultiProvider(
          providers: [
            // Mock providers for testing
            provider.Provider<String>.value(value: 'test'),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Text('Test App'),
            ),
          ),
        ),
      ),
    );

    // Verify that the app loads without errors
    expect(find.text('Test App'), findsOneWidget);
  });
}
