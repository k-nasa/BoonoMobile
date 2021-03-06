import 'package:flutter/material.dart';
import 'package:boono_mobile/screen/widget/add_description_list/type_select_field.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

import 'package:boono_mobile/screen/widget/add_description_list/subscription_list_view.dart';
import 'package:boono_mobile/screen/widget/add_description_list/create_description_form.dart';

class AddSubscriptionItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SubscriptionBlocProvider(
      child: Column(
        children: <Widget>[
          AddSubscriptionForm(),
          SubscriptionListView(),
          TypeSelectField(),
        ],
      ),
    );
  }
}
