import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fleetdrop_dispatch/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Updates heading coordinates', (WidgetTester tester) async {
    await tester.pumpWidget(const FleetDropApp());
    await tester.pumpAndSettle();
  });
}