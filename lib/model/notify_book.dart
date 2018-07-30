import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:boono_mobile/model/new_info.dart';

class NotifyBook {
  int id;
  String title;
  String author;
  String publish_date;
  String image_url;
  String big_image_url;
  String synopsis;
  String amount;

  NotifyBook({
    this.id,
    this.title,
    this.author,
    this.publish_date,
    this.image_url,
    this.big_image_url,
    this.synopsis,
    this.amount
  });

  static Future<List> all() async {
    if(await NewInfo.new_info()){
      try {
        return getBookDateFromServer();
      }

      catch (e){
        print(e);
        return getBookDateFromLocal();
      }
    }
    else
      return getBookDateFromLocal();
  }

  static Future<List<NotifyBook>> getBookDateFromServer() async {
    // 保存されているローカルデータを削除
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    DBManager db = new DBManager();
    String userToken = await db.fetchUserToken();

    final http.Response res = await http.get(
      NotifyBookURL + '/$userToken',
    );

    final List jsonArray = json.decode(res.body);
    List<NotifyBook> nBooks = [];

    for(var nBook in jsonArray) {
      String amount = nBook['book']['amount'].toString();
      amount = amount != '0' ? amount+'円' : '情報なし';

      NotifyBook notifyBook = new NotifyBook(
        id: nBook['notify_book']['id'],
        title:  nBook['book']['title'],
        author: nBook['book']['author'],
        image_url: nBook['book']['image_url'],
        big_image_url: nBook['book']['big_image_url'],
        publish_date: nBook['book']['publish_date'],
        synopsis: nBook['book']['synopsis'],
        amount: amount,
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

    for(var id in ids) {
      NotifyBook notifyBook = NotifyBook.fromStringList(prefs.getStringList('notifyBook$id'), int.parse(id));
      nBooks.add(notifyBook);
    }

    return nBooks;
  }

  Future<bool> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List ids = await prefs.getStringList('ids');
    http.Response res;

    if(ids.remove(id.toString())){
      await prefs.setStringList('ids', ids);
      await prefs.remove('notifyBook$id');


      res = await http.delete(
        NotifyBookURL + '/$id',
      );

      print(res.body);
    }

    if(res?.statusCode == 200)
      return true;

    return false;
  }

  Future<bool> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('ids') ?? [];
    ids.remove(id.toString()); //ダブリを消すため

    ids.add(id.toString());
    await prefs.setStringList('ids', ids);
    await prefs.setStringList('notifyBook$id', toStringList());
  }

  NotifyBook.fromStringList(List<String> list, int notifyBookId){
    id =            notifyBookId;
    title =         list[0];
    author =        list[1];
    image_url =     list[2];
    big_image_url = list[3];
    publish_date =  list[4];
    synopsis =      list[5];
    amount =        list[6];
  }
  List<String> toStringList() =>
      [
        title,
        author,
        image_url,
        big_image_url,
        publish_date,
        synopsis,
        amount,
      ];
}