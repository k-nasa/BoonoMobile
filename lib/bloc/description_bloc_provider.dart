import 'package:flutter/widgets.dart';

class DescriptionBlocProvider extends InheritedWidget {
  final DescriptionBloc descriptionBloc;

  DescriptionBlocProvider({
    Key key,
    Widget child,
    DescriptionBloc descriptionBloc,
}) : descriptionBloc  = descriptionBloc ?? DescriptionBloc(),
  super(key: key, child: child)

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
  }
}