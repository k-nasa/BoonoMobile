import 'dart:io';
import 'package:boono_mobile/screen/notify_book_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/new_info.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:mockery/mock_http_image.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  NotifyBook notifyBook = NotifyBook(
    id: 12,
    title: 'ブラックリスト',
    author: 'レイモンド・レディントン',
    imageUrl: 'dummyUrl',
    bigImageUrl: 'dummyUrl',
    publishDate: '2017-1-9',
    synopsis: 'あらすじ',
    amount: '400',
  );

  setUp(() async {
    await prefsMock();
  });

  testWidgets('notify_book_list_view', (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      await notifyBook.save();
      await NewInfo.updateNewInfo(false);

      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: NotifyBookListViewScreen()))
      );

      final Finder progress = find.byType(CircularProgressIndicator);
      expect(progress, findsOneWidget);


      await tester.pump(const Duration(milliseconds: 1000));
      await tester.pump(const Duration(milliseconds: 1000));
      final Finder listItem = find.byType(Card);
      expect(listItem, findsWidgets);

      final TestGesture gesture = await tester.startGesture(tester.getTopRight(listItem));
      await gesture.moveTo(tester.getTopLeft(listItem));

      await gesture.up();
      await tester.pump(const Duration(seconds: 1));
    }, createHttpClient: createMockImageHttpClient);
  });
}