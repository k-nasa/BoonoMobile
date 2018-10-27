import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class SubscriptionBlocProvider extends InheritedWidget {
  SubscriptionBlocProvider({
    Key key,
    SubscriptionBloc subscriptionBloc,
    @required Widget child,
  })  : subscriptionBloc = subscriptionBloc ?? SubscriptionBloc(),
        super(key: key, child: child);

  final SubscriptionBloc subscriptionBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SubscriptionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SubscriptionBlocProvider)
              as SubscriptionBlocProvider)
          .subscriptionBloc;
}
