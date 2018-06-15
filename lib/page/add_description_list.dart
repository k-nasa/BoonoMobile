import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/page/widget/type_select_field.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

class AddSubscriptionItemPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SubscriptionBlocProvider(
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();


  @override
  Widget build(BuildContext context) {
    void _submit() {
      if (_formKey.currentState.validate()) print('hoge');
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
                //onSaved: (val) { _content = val; },
                onFieldSubmitted:(_) => _submit(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('hoge1');
  }
}
