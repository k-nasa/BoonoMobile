import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:boono_mobile/model/subscription_item.dart';

class SubscriptionBloc{
  SubscriptionBloc() {
    _typeChangeController.stream.listen(_typeChange);
  }

  String content;
  String type = 'TitleItem';

  final StreamController<String> _typeChangeController =  StreamController<String>();
  Sink<String> get typeChange => _typeChangeController.sink;

  final BehaviorSubject<String> _type = BehaviorSubject<String>(seedValue: 'TitleItem');
  Stream<String> get typeString => _type.stream;


  final BehaviorSubject<bool> _showSelectField = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get showSelectField => _showSelectField.stream;
  Sink<bool> get showField => _showSelectField.sink;

  final BehaviorSubject<String> _content = BehaviorSubject<String>(seedValue: '');
  Stream<String> get contentString => _content.stream;

  final StreamController<bool> _rebuildListView = StreamController();
  Sink get rebuild => _rebuildListView.sink;
  Stream get rebuildListView => _rebuildListView.stream;

  void _typeChange(String typeString) {
    type = typeString;
    _type.add(type);
  }

  Future<bool> subscriptionSave() async {
    final SubscriptionItem subItem = SubscriptionItem(content: content, type: type);
    final bool isSaved = await subItem.save();

    _rebuildListView.add(true);
    return isSaved;
  }
}