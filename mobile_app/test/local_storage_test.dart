// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:arcore_test/controllers/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:arcore_test/main.dart';

void main() {
  /*testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that
    expect(find.text('Connectez vous'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text("Se connecter"));
    await tester.pump();
    // Verify that
    expect(find.text('Scanner le QR Code'), findsNWidgets(3));
  });*/

  test('Test add and get object from local storage', () async {
    String key = "KeyTest";
    String value = "ValueTest";
    // Add to local storage
    await LocalStorageProvider.setObject(key: key, value: value);
    // Check if it was added
    String? res = await LocalStorageProvider.getObject(key);

    expect(res, value);
  });
}
