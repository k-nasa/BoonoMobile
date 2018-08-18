import 'package:flutter/material.dart';
import 'package:boono_mobile/bloc/description_bloc.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';

class AddSubscriptionForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  Widget simpleSnackBar(String content) {
    return SnackBar(
      content: Text(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    SubscriptionBloc subscriptionBloc = SubscriptionBlocProvider.of(context);

    void listener(){
      if(focusNode.hasFocus)
        subscriptionBloc.showField.add(true);
      else
        subscriptionBloc.showField.add(false);
    }

    focusNode.addListener(listener);

    void _submit() async {
      if (_formKey.currentState.validate()) {
        subscriptionBloc.content = _controller.text;
        _controller.clear();

        if (await subscriptionBloc.subscriptionSave())
          Scaffold.of(context).showSnackBar(simpleSnackBar('作成しました'));
        else
          Scaffold.of(context).showSnackBar(simpleSnackBar('作成に失敗しました'));
      }
    }

    return new Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: new TextFormField(
                focusNode: focusNode,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: '購読リストに追加',
                ),
                controller: _controller,
                validator: (val) => val.isNotEmpty ? null : 'なにか入力してください！',
                onFieldSubmitted:(_) => _submit(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _submit();
              },
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}

