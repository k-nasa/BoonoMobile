import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';

class SubscriptionListView extends StatelessWidget {
  final SubscriptionItem subItem = SubscriptionItem();
  List<SubscriptionItem> subItems;

  @override
  Widget build(BuildContext context) {
    SubscriptionBloc subscriptionBloc = SubscriptionBlocProvider.of(context);

    return StreamBuilder<bool>(
      stream: subscriptionBloc.rebuildListView,
      initialData: true,
      builder: (_, snapshot) {
        if(snapshot.data) return SubscriptionListViewContent();
      },
    );
  }

  Widget SubscriptionListViewContent(){
    return FutureBuilder<List<SubscriptionItem>>(
        future: subItem.all(),
        builder: (_, snapshot) => Flexible(child: buildSubscriptionList(snapshot))
    );
  }

  Widget buildSubscriptionList(AsyncSnapshot<List<SubscriptionItem>> snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return new CircularProgressIndicator();
      default:
        if(snapshot.hasError)
          return ListView(
            children: <Widget>[
              Text("サーバーからの応答がないためリストを取得できません"),
            ],
          );

        subItems = snapshot.data;
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) => _createSubscription(index),
            itemCount: subItems.length
        );
    }
  }

  Widget _createSubscription(int index) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(subItems[index].content),
          subtitle: new Text(subItems[index].type),
        ),
        const Divider(height: 5.0,)
      ],
    );
  }
}
