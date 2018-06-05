import 'package:flutter/material.dart';

class AddDescriptionPage extends StatelessWidget {
  String _content;
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    saveContent(type){

    }

    Widget alertDialog = new AlertDialog(
      title: new Text("リストのタイプを選択してください"),
      content: new Text('内容: $_content'),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              saveContent('auther');
              Navigator.pop(context);
            },
            child: new Text('作者')
        ),
        new FlatButton(
            onPressed: () {
              saveContent('title');
              Navigator.pop(context);
            },
            child: new Text('タイトル')
        )
      ],
    );

    _submit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        print(_content);
        showDialog(
            context: context,
            builder: (_) => alertDialog
        );
      }
    }


    return new Container(
      child: new Form(
        key: _formKey,
        child: new Padding(
          padding: new EdgeInsets.only(top: 30.0, left: 20.0,right: 20.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextFormField(
                  decoration: new InputDecoration(
                    //contentPadding: new EdgeInsets.only(top: 20.0),
                    hintText: '購読リスト追加'
                  ),
                  validator: (val) => val.isNotEmpty ? null : 'なにか入力してください！',
                  onSaved: (val) => _content = val,
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    color: Colors.orangeAccent,
                    onPressed: () => _submit()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


