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

    return StreamBuilder(
      stream: subscriptionBloc.typeString,
      initialData: 'TitleItem',
      builder: (context, snapshot){
        final String type = snapshot.data;

        Color titleColor = type == 'TitleItem' ? Colors.blueAccent: Colors.black;
        Color authorColor = type == 'AuthorItem' ? Colors.blueAccent: Colors.black;

        return Container(
          color: Colors.blueGrey[50],
          child: Row(
            children: <Widget>[
              Text('リストのタイプを選択'),
              Padding(padding: EdgeInsets.all(10.0),),
              FlatButton(
                child: Text('タイトル', style: TextStyle(color: titleColor)),
                onPressed: () => subscriptionBloc.typeChange.add(TypeChange('TitleItem')),
              ),
              FlatButton(
                child: Text('作者', style: TextStyle(color: authorColor),),
                onPressed: () => subscriptionBloc.typeChange.add(TypeChange('AuthorItem')),
              ),
            ],
          ),
        );
      },
    );
  }

}
