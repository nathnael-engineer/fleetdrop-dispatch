import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fleetdrop_dispatch/main.dart';

void main() {
  testWidgets('Renders route banner and coordinates', (WidgetTester tester) async {
    await tester.pumpWidget(const FleetDropApp());
    await tester.pumpAndSettle();

    expect(find.text('FleetDrop Dispatch'), findsOneWidget);
    expect(find.text('ACTIVE ROUTE: KALMAN FILTER ENGAGED'), findsOneWidget);
  });
}