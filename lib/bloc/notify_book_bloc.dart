import 'dart:async';
import 'package:rxdart/rxdart.dart';

class NotifyBookBloc {

  // TODO Stream, Sinkについて見直そう！
  // listenerなしでも実装できるはず
  NotifyBookBloc() {
    _rebuildListViewController.stream.listen( (_) {
      _rebuild.add(true);
    });
  }

  final StreamController<bool> _rebuildListViewController = StreamController<bool>();
  Sink<bool> get rebuildListView => _rebuildListViewController.sink;

  final BehaviorSubject<bool> _rebuild = BehaviorSubject<bool>(seedValue: true);
  Stream<bool> get isRebuildListView => _rebuild.stream;

}