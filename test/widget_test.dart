import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finyx_mobile_app/main.dart';

class MockNotifications extends Fake implements FlutterLocalNotificationsPlugin {}

void main() {
  final mockNotifications = MockNotifications();

  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(notificationsPlugin: mockNotifications));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}