import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/screen/widget/add_description_list/custom_list_tile.dart';

// ignore: must_be_immutable
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
        if(snapshot.data)
          return subscriptionListViewContent();
      },
    );
  }

  Widget subscriptionListViewContent(){
    return FutureBuilder(
        future: SubscriptionItem.all(),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            Flexible(
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                    child: buildSubscriptionList(snapshot))
        )
    );
  }

  Widget buildSubscriptionList(AsyncSnapshot snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return const CircularProgressIndicator();
      default:
        if(snapshot.hasError)
          // FIXME
          return ListView(
            children: const <Widget>[
              Text('サーバーからの応答がないためリストを取得できません'),
            ],
          );

        if(snapshot.data == null){
          // MEMO カスタムメニューを画面下に出したいのでListViewにして返している
          return ListView(
            children: const <Widget>[
              Center(
                child: Text(
                    '''まだ購読リストに登録されていません。
                    \n購読したい本を登録して、新着本情報を受け取りましょう'''
                ),
              )
            ],
          );
        }

        subItems = snapshot.data;
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) => _createSubscription(context, index),
            itemCount: subItems?.length
        );
    }
  }

  Widget _createSubscription(BuildContext context, int index) {
    return Card(
        color: Theme.of(context).secondaryHeaderColor,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: CustomListTile(subItem: subItems[index])
    );
  }
}
