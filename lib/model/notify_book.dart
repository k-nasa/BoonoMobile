import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';

class NotifyBook {
  int id;
  String title;
  String author;
  String publish_date;
  String image_url;

  NotifyBook({this.id, this.title, this.author, this.publish_date, this.image_url});

  static Future<List> all() async {
    DBManager db = new DBManager();
    String userToken = await db.fetchUserToken();

    final http.Response res = await http.get(
      NotifyBookURL + '/$userToken',
    );

    final List jsonArray = json.decode(res.body);
    List<NotifyBook> nBooks = [];

    for(var nBook in jsonArray) {
      nBooks.add(
        new NotifyBook(
          id: nBook['notify_book']['id'],
          title:  nBook['book']['title'],
          author: nBook['book']['author'],
          image_url: nBook['book']['image_url'],
          publish_date: nBook['book']['publish_date'],
        )
      );
    }

    return nBooks;
  }
}