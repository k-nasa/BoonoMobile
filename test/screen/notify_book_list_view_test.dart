import 'package:boono_mobile/screen/notify_book_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('notify_book_list_view', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: NotifyBookListViewScreen()))
    );
  });
}