import 'dart:async';
import 'package:rxdart/rxdart.dart';

class NotifyBookBloc {
  StreamController<bool> _rebuildListViewController = StreamController<bool>();
  Sink get rebuildListView => _rebuildListViewController.sink;

  BehaviorSubject<bool> _rebuild = BehaviorSubject(seedValue: true);
  Stream get isRebuildListView => _rebuild.stream;

  NotifyBookBloc() {
    _rebuildListViewController.stream.listen( (i) {
      _rebuild.add(true);
    });
  }
}