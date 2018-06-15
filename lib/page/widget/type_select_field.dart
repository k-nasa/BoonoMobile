import 'package:flutter/material.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class TypeSelectField extends StatelessWidget{
  String type;

  @override
  Widget build(BuildContext context) {
    final descriptionBloc = DescriptionBlocProvider.of(context);
    return StreamBuilder(
      stream: descriptionBloc.typeString,
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
                onPressed: () => descriptionBloc.typeChange.add(TypeChange('TitleItem')),
                color: type == 'TitleItem' ? Colors.blueAccent: Colors.black,
              ),
              IconButton(
                tooltip: '作者',
                icon: Icon(Icons.account_circle),
                onPressed: () => descriptionBloc.typeChange.add(TypeChange('AuthorItem')),
                color: type == 'AuthorItem' ? Colors.blueAccent: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }
}
