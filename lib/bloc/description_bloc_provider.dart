import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class DescriptionBlocProvider extends InheritedWidget {
  final DescriptionBloc descriptionBloc;

  DescriptionBlocProvider({
    Key key,
    DescriptionBloc descriptionBloc,
    @required Widget child,
  }) : descriptionBloc  = descriptionBloc ?? DescriptionBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static DescriptionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DescriptionBlocProvider) as DescriptionBlocProvider)
          .descriptionBloc;
}