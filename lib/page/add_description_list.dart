import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/page/widget/type_select_field.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

class AddSubscriptionItemPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return DescriptionBlocProvider(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AddSubscriptionForm(),
          SubscriptionListView(),
          TypeSelectField(),
        ],
      ),
    );
  }
}

class AddSubscriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('hoge');
  }
}

class SubscriptionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('hoge1');
  }
}
