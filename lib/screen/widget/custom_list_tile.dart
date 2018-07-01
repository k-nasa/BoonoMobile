import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

class CustomListTile extends StatefulWidget {
  CustomListTile({this.subItem});

  SubscriptionItem subItem;
  @override
  _CustomListTileState createState() => new _CustomListTileState(subItem: subItem);
}

class _CustomListTileState extends State<CustomListTile> {
  _CustomListTileState({this.subItem}):
        content = subItem.content, type = subItem.type;

  SubscriptionItem subItem;
  String content;
  String type;
  bool isLongTap = false;
  IconData tileIcon;

  initState() {
    tileIcon = type == 'AuthorItem' ? Icons.account_circle : Icons.book;
  }

  void openMenu(){
    setState(() {
      isLongTap = true;
    });
  }
  void closeMenu(){
    setState(() {
      isLongTap = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    SubscriptionBloc subscriptionBloc = SubscriptionBlocProvider.of(context);

    void deleteSubItem () async {
      if (await subItem.delete())
        Scaffold.of(context).showSnackBar(SnackBar(content: new Text("削除しました")));
      else {
        Scaffold.of(context).showSnackBar(SnackBar(content: new Text('削除に失敗しました')));
      }
      subscriptionBloc.rebuild.add(true);
    }

    Widget defaultTile(){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: ListTile(
            title: Text(content),
            leading: Icon(tileIcon,color: Colors.blue,),
            trailing: IconButton(
              icon: Icon(Icons.close, color: Colors.red,),
              onPressed: () => openMenu(),
            ),
          ),
        ),
      );
    }

    Widget customTile(){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: ListTile(
            title: Text(content),
            leading: IconButton(
                icon: Icon(Icons.close),
                color: Colors.lightBlue,
                onPressed: () => closeMenu()
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () => deleteSubItem(),
            ),
          ),
        ),
      );
    }

    return isLongTap ? customTile() : defaultTile();
  }
}
