import 'package:boono_mobile/route/api_routes.dart';
import 'package:http/http.dart'as http ;
import 'package:boono_mobile/config/db_manager.dart';
import 'dart:convert';
import 'dart:async';

class SubscriptionItem {
  String content;
  String type;
  int id;

  SubscriptionItem({this.content, this.type, this.id});

  Future<bool> save() async {
  }

  Future<bool> delete() async {
  }

  static Future<List<SubscriptionItem>> all() async{
  }

  Map _toMap() =>
      <String, dynamic>{
        'type': type,
        'content': content,
      };
}