import 'dart:async';
import 'package:rxdart/rxdart.dart';

class NotifyBookBloc {
  final BehaviorSubject<bool> _rebuild = BehaviorSubject<bool>(seedValue: true);
  Stream<bool> get isRebuildListView => _rebuild.stream;
  Sink<bool> get rebuildListView => _rebuild.sink;
}
