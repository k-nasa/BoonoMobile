import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:boono_mobile/model/subscription_item.dart';

class TypeChange{
  final String type;
  TypeChange(this.type);
}

class ShowSelectField {
  final bool isShow;
  ShowSelectField(this.isShow);
}

class SubscriptionBloc{
  SubscriptionBloc() {
    _typeChangeController.stream.listen(_typeChange);
    _showSelectFieldController.stream.listen(_showSelect);
  }

  String content;
  String type = 'TitleItem';

  final StreamController<TypeChange> _typeChangeController =  StreamController<TypeChange>();
  Sink<TypeChange> get typeChange => _typeChangeController.sink;

  final StreamController<ShowSelectField> _showSelectFieldController = StreamController<ShowSelectField>();
  Sink<ShowSelectField> get showField => _showSelectFieldController.sink;

  final BehaviorSubject<String> _type = BehaviorSubject<String>(seedValue: 'TitleItem');
  Stream<String> get typeString => _type.stream;

  final BehaviorSubject<bool> _showSelectField = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get showSelectField => _showSelectField.stream;

  final BehaviorSubject<String> _content = BehaviorSubject<String>(seedValue: '');
  Stream<String> get contentString => _content.stream;

  final StreamController<bool> _rebuildListView = StreamController();
  Sink get rebuild => _rebuildListView.sink;
  Stream get rebuildListView => _rebuildListView.stream;

  void _typeChange(TypeChange typeChange) {
    type = typeChange.type;
    _type.add(type);
  }


  void _showSelect(ShowSelectField showSelectField) {
    _showSelectField.add(showSelectField.isShow);
  }

  Future<bool> subscriptionSave() async {
    final SubscriptionItem subItem = SubscriptionItem(content: content, type: type);
    final bool isSaved = await subItem.save();

    _rebuildListView.add(true);
    return isSaved;
  }
}