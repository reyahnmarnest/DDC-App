import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dimaanos_dental_clinic/main.dart'; // ✅ Correct project name


void main() {
  testWidgets('App starts and shows LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(const DimaanosDentalApp());

    await tester.pumpAndSettle();

    // Check if the main heading or clinic title is visible
    expect(find.text("DIMAANO'S DENTAL CLINIC"), findsOneWidget);

    // Check for two input fields (email & password)
    expect(find.byType(TextField), findsNWidgets(2));

    // Check for Login button (if uppercase is used)
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);

    expect(find.textContaining('login', findRichText: true), findsWidgets);

    // Check for Sign Up text button
    expect(find.text('Sign Up'), findsOneWidget);

    // Check for Forgot Password text button
    expect(find.text('Forgot Password?'), findsOneWidget);
  });
}
