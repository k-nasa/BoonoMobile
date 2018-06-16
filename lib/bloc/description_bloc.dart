import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:boono_mobile/model/subscription_item.dart';

class TypeChange{
  final String type;
  TypeChange(this.type);
}

class SetContent {
  final String content;
  SetContent(this.content);
}

class ShowSelectField {
  final bool isShow;
  ShowSelectField(this.isShow);
}

class SubscriptionBloc{
  String content;
  String type = 'TitleItem';

  final StreamController<TypeChange> _typeChangeController =  StreamController<TypeChange>();
  Sink<TypeChange> get typeChange => _typeChangeController.sink;

  final StreamController<SetContent> _setContentController = StreamController<SetContent>();
  Sink<SetContent> get setContent => _setContentController.sink;

  final StreamController<ShowSelectField> _showSelectFieldController = StreamController<ShowSelectField>();
  Sink<ShowSelectField> get showField => _showSelectFieldController.sink;

  final BehaviorSubject<String> _type = BehaviorSubject<String>(seedValue: 'TitleItem');
  Stream<String> get typeString => _type.stream;

  final BehaviorSubject<bool> _showSelectField = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get showSelectField => _showSelectField.stream;

  final BehaviorSubject<String> _content = BehaviorSubject<String>(seedValue: '');
  Stream<String> get contentString => _content.stream;

  final BehaviorSubject<bool> _rebuildListView= BehaviorSubject<bool>(seedValue: true);
  Stream<bool> get rebuildListView => _rebuildListView.stream;


  SubscriptionBloc() {
    _typeChangeController.stream.listen(_typeChange);
    _setContentController.stream.listen(_setContent);
    _showSelectFieldController.stream.listen(_showSelect);
  }

  void _typeChange(TypeChange typeChange) {
    type = typeChange.type;
    _type.add(type);
  }

  void _setContent(SetContent setContent) { content = setContent.content; }

  void _showSelect(ShowSelectField showSelectField) {
    _showSelectField.add(showSelectField.isShow);
  }

  Future<bool> subscriptionSave() async {
    SubscriptionItem subItem = SubscriptionItem(content: content, type: type);
    bool isSaved = await subItem.save();
    return isSaved;
  }
}