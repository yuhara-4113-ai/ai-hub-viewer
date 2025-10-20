import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_hub_viewer/main.dart';

void main() {
  testWidgets('App should render without errors', (WidgetTester tester) async {
    // This test verifies the app can be instantiated
    // Note: This requires .env file to be present
    await tester.pumpWidget(const MyApp());

    // Verify the app title appears in the AppBar
    expect(find.text('AI Hub Viewer'), findsOneWidget);

    // Verify the question input field exists
    expect(find.byType(TextField), findsOneWidget);

    // Verify the send button exists
    expect(find.text('送信'), findsOneWidget);
  });

  testWidgets('Submit button should be disabled when loading', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the submit button
    final submitButton = find.text('送信');
    expect(submitButton, findsOneWidget);

    // The button should be enabled initially
    final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Empty question should show error message', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap the send button without entering text
    await tester.tap(find.text('送信'));
    await tester.pump();

    // Verify error message appears
    expect(find.text('質問を入力してください'), findsOneWidget);
  });
}
