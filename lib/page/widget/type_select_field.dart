import 'package:flutter/material.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class TypeSelectField extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final subscriptionBloc = SubscriptionBlocProvider.of(context);
    return StreamBuilder<bool>(
      stream: subscriptionBloc.showSelectField,
      initialData: false,
      builder: (_, snapshot){
        if (snapshot.data == true ) return TypeSelectFieldContent();
        else return Container();
      },
    );
  }
}

class TypeSelectFieldContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subscriptionBloc = SubscriptionBlocProvider.of(context);
    String type;

    return StreamBuilder(
      stream: subscriptionBloc.typeString,
      initialData: 'TitleItem',
      builder: (context, snapshot){
        type = snapshot.data;
        return Container(
          child: Row(
            children: <Widget>[
              Text('リストのタイプを選択'),
              Padding(padding: EdgeInsets.all(10.0),),
              IconButton(
                tooltip: '本',
                icon: Icon(Icons.book),
                onPressed: () => subscriptionBloc.typeChange.add(TypeChange('TitleItem')),
                color: type == 'TitleItem' ? Colors.blueAccent: Colors.black,
              ),
              IconButton(
                tooltip: '作者',
                icon: Icon(Icons.account_circle),
                onPressed: () => subscriptionBloc.typeChange.add(TypeChange('AuthorItem')),
                color: type == 'AuthorItem' ? Colors.blueAccent: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }

}
