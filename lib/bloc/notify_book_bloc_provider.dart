import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';
import 'package:boono_mobile/bloc/notify_book_bloc.dart';

class NotifyBookBlocProvider extends InheritedWidget {
  final NotifyBookBloc notifyBookBloc;

  NotifyBookBlocProvider({
    Key key,
    NotifyBookBloc notifyBookBloc,
    @required Widget child,
  }) : notifyBookBloc = notifyBookBloc ?? NotifyBookBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static NotifyBookBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(NotifyBookBlocProvider) as NotifyBookBlocProvider)
          .notifyBookBloc;
}
