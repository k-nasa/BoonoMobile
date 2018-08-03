import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  group('NotifyBook', () {
    List<String> stringList = [
      'ブラックリスト',
      'レイモンド・レディントン',
      'dummyUrl',
      'dummyUrl',
      '2017-1-9',
      'あらすじ',
      '400',
    ];

    NotifyBook nBook = NotifyBook(
      id: 12,
      title: 'ブラックリスト',
      author: 'レイモンド・レディントン',
      imageUrl: 'dummyUrl',
      bigImageUrl: 'dummyUrl',
      publishDate: '2017-1-9',
      synopsis: 'あらすじ',
      amount: '400',
    );

    test('fromStringList',() {
      expect(NotifyBook.fromStringList(stringList, 12) == nBook, isTrue);
      expect(NotifyBook.fromStringList(stringList, 13) == nBook, isFalse);
    });

    test('toStringList', (){
      Function eq = const ListEquality<dynamic>().equals;

      expect(true, eq(stringList,nBook.toStringList()));
    });
  });
}