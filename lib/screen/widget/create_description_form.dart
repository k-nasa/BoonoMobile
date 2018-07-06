import 'package:flutter/material.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

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
        await _formKey.currentState.save();
        _controller.clear();

        if (await subscriptionBloc.subscriptionSave())
          Scaffold.of(context).showSnackBar(SimpleSnackBar('作成しました'));
        else
          Scaffold.of(context).showSnackBar(SimpleSnackBar('作成に失敗しました'));
      }
    }

    return new Form(
      key: _formKey,
      child: Container(
        padding: new EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  filled: true,
                  labelText: '購読リストに追加',
                ),
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

