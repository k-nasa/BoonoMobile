import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TypeChange{
  final String type;
  TypeChange(this.type);
}

class DescriptionBloc{
  String content;
  String type;

  final StreamController<TypeChange> _typeChangeController =  StreamController<TypeChange>();
  Sink<TypeChange> get typeChange => _typeChangeController.sink;

  final BehaviorSubject<String> _type = BehaviorSubject<String>(seedValue: 'TitleItem');
  Stream<String> get typeString => _type.stream;

  DescriptionBloc() {
    _typeChangeController.stream.listen(_typeChange);
  }

  void _typeChange(TypeChange typeChange) {
    type = typeChange.type;
    print(type);
    _type.add(type);
  }
}