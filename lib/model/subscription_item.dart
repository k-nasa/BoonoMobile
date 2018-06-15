import 'package:boono_mobile/route/api_routes.dart';
import 'package:http/http.dart'as http ;
import 'package:boono_mobile/config/db_manager.dart';
import 'dart:convert';
import 'dart:async';

class SubscriptionItem {
  String content;
  String type;

  SubscriptionItem({this.content, this.type});

  Future<bool> save() async {
    DBManager db = new  DBManager();
    String userToken = await db.fetchUserToken();

    final res = await http.post(
        SubscriptionCreateURL,
        body: {
          'content': content,
          'type': type,
          'token': userToken
        }
    ).catchError((Error e) => null );

    if (res.statusCode == 201)
      return true;
    else
      return false;
  }

  Future<List<SubscriptionItem>> all() async{
    DBManager db = new DBManager();
    String userToken = await db.fetchUserToken();

    final http.Response res = await http.get(
      SubscriptionsURL + '/$userToken',
    );

    final List jsonArray = json.decode(res.body);
    List<SubscriptionItem> subItems = [];

    for(var subItem in jsonArray){
      subItems.add(
          new SubscriptionItem(
              content: subItem['content'],
              type: subItem['type']
          )
      );
    }

    return subItems;
  }
}