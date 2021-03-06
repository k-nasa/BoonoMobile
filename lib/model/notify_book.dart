import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:boono_mobile/model/new_info.dart';

class NotifyBook {
  NotifyBook({
    this.id,
    this.title,
    this.author,
    this.publishDate,
    this.imageUrl,
    this.detailUrl,
    //this.bigImageUrl,
    //this.synopsis,
    //this.amount
  });

  NotifyBook.fromStringList(List<String> list, int notifyBookId) {
    id = notifyBookId.toInt();
    title = list[0];
    author = list[1];
    imageUrl = list[2];
    detailUrl = list[3];
    publishDate = list[4];
    //bigImageUrl = list[3];
    //synopsis = list[6];
    //amount = list[7];
  }

  int id;
  String title;
  String author;
  String publishDate;
  String imageUrl;
  String detailUrl;
  //String bigImageUrl;
  //String synopsis;
  //String amount;


  static Future<List> all() async {
    if (!await NewInfo.newInfo())
      return getBookDateFromLocal();

    try {
      return getBookDateFromServer();
    } catch (e) {
      print(e);
      return getBookDateFromLocal();
    }
  }

  static Future<List<NotifyBook>> getBookDateFromServer() async {
    // 保存されているローカルデータを削除
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    DBManager db = new DBManager();
    final String userToken = await db.fetchUserToken();

    final http.Response res = await http.get(
      NotifyBookURL + '/$userToken',
    );

    final List jsonArray = json.decode(res.body);

    final List<NotifyBook> nBooks = [];

    for (var nBook in jsonArray) {
      String amount = nBook['book']['amount'].toString();
      amount = amount != '0' ? amount + '円' : '情報なし';

      NotifyBook notifyBook = new NotifyBook(
        id: nBook['notify_book']['id'],
        title: nBook['book']['title'],
        author: nBook['book']['author'],
        imageUrl: nBook['book']['image_url'],
        detailUrl: nBook['book']['detail_url'],
        publishDate: nBook['book']['publish_date'],
        //bigImageUrl: nBook['book']['big_image_url'],
        //synopsis: nBook['book']['synopsis'],
        //amount: amount,
      );

      notifyBook.save();
      NewInfo.updateNewInfo(false);
      nBooks.add(notifyBook);
    }

    return nBooks;
  }

  static Future<List<NotifyBook>> getBookDateFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('ids') ?? [];
    List<NotifyBook> nBooks = [];

    for (var id in ids) {
      NotifyBook notifyBook = NotifyBook.fromStringList(
          prefs.getStringList('notifyBook$id'), int.parse(id));

      nBooks.add(notifyBook);
    }

    return nBooks;
  }

  Future<bool> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List ids = await prefs.getStringList('ids');
    http.Response res;

    if (ids.remove(id.toString())) {
      await prefs.setStringList('ids', ids);
      await prefs.remove('notifyBook$id');

      res = await http.delete(
        NotifyBookURL + '/$id',
      );

      print(res.body);
    }

    if (res?.statusCode == 200) return true;

    return false;
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('ids') ?? [];
    ids.remove(id.toString()); //ダブリを消すため

    ids.add(id.toString());
    await prefs.setStringList('ids', ids);
    await prefs.setStringList('notifyBook$id', toStringList());
  }

  List<String> toStringList() => [
        title,
        author,
        imageUrl,
        detailUrl,
        publishDate,
        //bigImageUrl,
        //synopsis,
        //amount,
      ];

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is NotifyBook &&
        other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.detailUrl == detailUrl;
        //other.bigImageUrl == bigImageUrl &&
        //other.synopsis == synopsis &&
        //other.amount == amount;
  }
}
