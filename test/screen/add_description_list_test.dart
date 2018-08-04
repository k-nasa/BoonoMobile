import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/screen/add_description_list.dart';

void main() {
  testWidgets('AddSubscriptionItemPage', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: Scaffold(
                body: AddSubscriptionItemPage()
            )
        )
    );
  });
}