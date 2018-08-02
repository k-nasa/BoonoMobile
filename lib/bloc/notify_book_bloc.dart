import 'dart:async';
import 'package:rxdart/rxdart.dart';

class NotifyBookBloc {

  NotifyBookBloc() {
    _rebuildListViewController.stream.listen( (i) {
      _rebuild.add(true);
    });
  }

  StreamController<bool> _rebuildListViewController = StreamController<bool>();
  Sink<bool> get rebuildListView => _rebuildListViewController.sink;

  BehaviorSubject<bool> _rebuild = BehaviorSubject(seedValue: true);
  Stream<bool> get isRebuildListView => _rebuild.stream;

}