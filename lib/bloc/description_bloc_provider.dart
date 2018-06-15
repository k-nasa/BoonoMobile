import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class SubscriptionBlocProvider extends InheritedWidget {
  final SubscriptionBloc subscriptionBloc;

  SubscriptionBlocProvider({
    Key key,
    SubscriptionBloc subscriptionBloc,
    @required Widget child,
  }) : subscriptionBloc = subscriptionBloc ?? SubscriptionBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static SubscriptionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SubscriptionBlocProvider) as SubscriptionBlocProvider)
          .subscriptionBloc;
}