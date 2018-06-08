import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';

class AddSubscriptionItemPage extends StatefulWidget {
  @override
  _AddSubscriptionItemPageState createState() => new _AddSubscriptionItemPageState();
}

class _AddSubscriptionItemPageState extends State<AddSubscriptionItemPage> {

  String _content;
  String _type;
  List<SubscriptionItem> subItems;
  final _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  saveSubscriptionItem() {
    var subscriptionItem = new SubscriptionItem(content: _content, type: _type);
    subscriptionItem.save();
    Navigator.pop(context);

    setState(() { //rebuildのために追加
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget alertDialog = new AlertDialog(
      title: new Text("リストのタイプを選択してください"),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _type = 'AuthorItem';
              saveSubscriptionItem();
            },
            child: new Text('作者')
        ),
        new FlatButton(
            onPressed: () {
              _type = 'TitleItem';
              saveSubscriptionItem();
            },
            child: new Text('タイトル')
        )
      ],
    );


    _submit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        showDialog(
            context: context,
            builder: (_) => alertDialog
        );
      }
    }

    Widget addSubscriptionForm () {
      return new Form(
        key: _formKey,
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextFormField(
                  decoration: new InputDecoration(
                    //contentPadding: new EdgeInsets.only(top: 20.0),
                      hintText: '購読リスト追加'
                  ),
                  validator: (val) => val.isNotEmpty ? null : 'なにか入力してください！',
                  onSaved: (val) {
                    setState(() {
                      _content = val;
                    });
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    color: Colors.blue,
                    onPressed: () => _submit()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


