import 'package:flutter/material.dart';
import 'package:boono_mobile/screen//widget/type_select_field.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

import 'package:boono_mobile/screen/widget/subscription_list_view.dart';

class AddSubscriptionItemPage extends StatelessWidget{
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

class AddSubscriptionForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  Widget SimpleSnackBar(String content) {
    return SnackBar(
      content: Text(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    SubscriptionBloc subscriptionBloc = SubscriptionBlocProvider.of(context);

    void listener(){
      if(focusNode.hasFocus)
        subscriptionBloc.showField.add(ShowSelectField(true));
      else
      subscriptionBloc.showField.add(ShowSelectField(false));
    }

    focusNode.addListener(listener);

    void _submit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _controller.clear();

        if (await subscriptionBloc.subscriptionSave())
          Scaffold.of(context).showSnackBar(SimpleSnackBar('作成しました'));
        else
          Scaffold.of(context).showSnackBar(SimpleSnackBar('作成に失敗しました'));
      }
    }

    return new Form(
      key: _formKey,
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(hintText: '購読リスト追加',),
                controller: _controller,
                validator: (val) => val.isNotEmpty ? null : 'なにか入力してください！',
                onSaved: (val) => subscriptionBloc.setContent.add(SetContent(val)),
                onFieldSubmitted:(_) => _submit(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

