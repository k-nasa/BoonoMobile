import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boono_mobile/model/new_info.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  group('NotifyBook', () {
    List<String> stringList = [
      'ブラックリスト',
      'レイモンド・レディントン',
      'dummyUrl',
      'dummyUrl',
      '2017-1-9',
      //'dummyUrl',
      //'あらすじ',
      //'400',
    ];

    NotifyBook nBook = NotifyBook(
      id: 12,
      title: 'ブラックリスト',
      author: 'レイモンド・レディントン',
      imageUrl: 'dummyUrl',
      detailUrl: 'dummyUrl',
      publishDate: '2017-1-9',
      //bigImageUrl: 'dummyUrl',
      //synopsis: 'あらすじ',
      //amount: '400',
    );

    NotifyBook nBook2 = NotifyBook(
      id: 13,
      title: 'ブラックリスト',
      author: 'レイモンド・レディントン',
      imageUrl: 'dummyUrl',
      detailUrl: 'dummyUrl',
      publishDate: '2017-1-9',
      //bigImageUrl: 'dummyUrl',
      //synopsis: 'あらすじ',
      //amount: '400',
    );

    SharedPreferences prefs;
    Function eq;

    setUp(() async {
      eq = const ListEquality<dynamic>().equals;
      prefs = await prefsMock();
    });

    tearDown(() {
      prefs.clear();
    });

    test('fromStringList', () {
      expect(NotifyBook.fromStringList(stringList, 12) == nBook, isTrue);
      expect(NotifyBook.fromStringList(stringList, 13) == nBook, isFalse);
    });

    test('toStringList', () {
      expect(eq(stringList, nBook.toStringList()), isTrue);
    });

    test('save', () async {
      var id = nBook.id;

      expect(prefs.getStringList('ids'), null);
      expect(prefs.getStringList('notifyBook$id'), null);

      await nBook.save();

      expect([id.toString()], prefs.getStringList('ids'));
      expect(nBook.toStringList(), prefs.getStringList('notifyBook$id'));
    });

    test('delete', () async {
      var id = nBook.id;

      await nBook.save();

      expect([nBook.id.toString()], prefs.getStringList('ids'));
      expect(nBook.toStringList(), prefs.getStringList('notifyBook$id'));

      await nBook.delete();

      expect(prefs.getStringList('ids'), isEmpty);
      expect(prefs.getStringList('notifyBook$id'), null);
    });

    test('getBookDateFromLocal', () async {
      expect(await NotifyBook.getBookDateFromLocal(), isEmpty);

      await nBook.save();
      await nBook2.save();

      expect(
          eq(await NotifyBook.getBookDateFromLocal(), [nBook, nBook2]), isTrue);
    });

    group('all', () {
      test('サーバー上のデータに変更がない時', () async {
        NewInfo.updateNewInfo(false);
        await nBook.save();
        await nBook2.save();

        expect(eq(await NotifyBook.all(), [nBook, nBook2]), isTrue);
      });

      test('サーバ城のデータに変更があった時', () async {
        //TODO Mockの実装が必要
      });
    });
  });
}
