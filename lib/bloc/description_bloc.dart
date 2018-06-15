import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TypeChange{
  final String type;
  TypeChange(this.type);
}

class SetContent {
  final String content;
  SetContent(this.content);
}

class SubscriptionBloc{
  String content;
  String type = 'TitleItem';

  final StreamController<TypeChange> _typeChangeController =  StreamController<TypeChange>();
  Sink<TypeChange> get typeChange => _typeChangeController.sink;

  final StreamController<SetContent> _setContentController = StreamController<SetContent>();
  Sink<SetContent> get setContent => _setContentController.sink;

  final BehaviorSubject<String> _type = BehaviorSubject<String>(seedValue: 'TitleItem');
  Stream<String> get typeString => _type.stream;

  final BehaviorSubject<String> _content = BehaviorSubject<String>(seedValue: '');
  Stream<String> get contentString => _content.stream;


  SubscriptionBloc() {
    _typeChangeController.stream.listen(_typeChange);
    _setContentController.stream.listen(_setContent);
  }

  void _typeChange(TypeChange typeChange) {
    type = typeChange.type;
    _type.add(type);
  }

  void _setContent(SetContent setContent) {
    content = setContent.content;
    print(content);
    print(type);
  }
}