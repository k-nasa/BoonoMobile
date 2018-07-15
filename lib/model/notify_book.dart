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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(await prefs.clear())
        return getBookDateFromServer();
    }
    else
      return getBookDateFromLocal();
  }

  static Future<List<NotifyBook>> getBookDateFromServer() async {
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

  Future<bool> delete() async {
    final http.Response res = await http.delete(
      NotifyBookURL + '/$id',
    );

    print(res.body);
    if(res?.statusCode == 200)
      return true;

    return false;
  }
}