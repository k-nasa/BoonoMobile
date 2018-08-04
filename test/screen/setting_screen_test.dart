import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/screen/setting_screen.dart';

void main() {
  testWidgets('setting_screen', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SettingScreen()))
    );
  });
}
