import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/screen/widget/add_description_list/custom_list_tile.dart';

// ignore: must_be_immutable
class SubscriptionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SubscriptionBloc subscriptionBloc = SubscriptionBlocProvider.of(context);

    return StreamBuilder<bool>(
      stream: subscriptionBloc.rebuildListView,
      initialData: true,
      builder: (_, snapshot) {
        return new SubscriptionListViewContent();
      },
    );
  }

}

class SubscriptionListViewContent extends StatefulWidget {
  @override
  _SubscriptionListViewContentState createState() => new _SubscriptionListViewContentState();
}

class _SubscriptionListViewContentState extends State<SubscriptionListViewContent> {
  List<SubscriptionItem> subItems;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: SubscriptionItem.all(),
        builder: (_, AsyncSnapshot snapshot) => new Flexible(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                child: buildSubscriptionList(snapshot))
        )
    );
  }

  Widget buildSubscriptionList(AsyncSnapshot snapshot) {
    switch(snapshot.connectionState){
      case ConnectionState.none:
      case ConnectionState.waiting:
        return CircularProgressIndicator();
      default:
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
        print(subItems.length);
        return new ListView.builder(
            itemBuilder: (BuildContext context, int index) => _createSubscription(context, index),
            itemCount: subItems.length
        );
    }
  }

  Widget _createSubscription(BuildContext context, int index) {
    return new Card(
        color: Theme.of(context).secondaryHeaderColor,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: new CustomListTile(subItem: subItems[index])
    );
  }
}
