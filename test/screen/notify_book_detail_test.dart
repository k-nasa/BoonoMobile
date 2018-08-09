import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/screen/notify_book_detail.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:mockery/mock_http_image.dart';

void main() {
  testWidgets('NotifyBookDetail', (WidgetTester tester) async {
    HttpOverrides.runZoned( () async {
      NotifyBook nBook = NotifyBook(
        id: 12,
        title: 'ブラックリスト',
        author: 'レイモンド・レディントン',
        imageUrl: 'https://pbs.twimg.com/profile_images/874463635950551040/IhlhyWsq_400x400.jpg',
        bigImageUrl: 'https://pbs.twimg.com/profile_images/874463635950551040/IhlhyWsq_400x400.jpg',
        publishDate: '2017-1-9',
        synopsis: 'あらすじ',
        amount: '400',
      );
      await tester.pumpWidget(Detail(nBook));
    }, createHttpClient: createMockImageHttpClient);
  });
}