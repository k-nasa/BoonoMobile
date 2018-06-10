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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode _focusNode = new FocusNode();

  void _listener(){
    if(_focusNode.hasFocus)
      print('foucused');
    else
      print('not foucesed');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveSubscriptionItem() async{
    final SubscriptionItem subscriptionItem = new SubscriptionItem(content: _content, type: _type);

    if (await subscriptionItem.save()){
      _controller.clear();
      Scaffold.of(context).showSnackBar(simpleSnackBar('購読リストに追加しました'));
    }
    else
      Scaffold.of(context).showSnackBar(simpleSnackBar('購読リストに追加に失敗しました'));

    Navigator.pop(context);

    //rebuildのために追加
    setState(() => null);
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
                      hintText: '購読リスト追加',
                  ),
                  controller: _controller,
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
      );
    }

    Widget subscriptionListPage() {
      SubscriptionItem subItem = new SubscriptionItem();

      return FutureBuilder<List<SubscriptionItem>>(
          future: subItem.all(),
          builder: (context, snapshot) => buildSubscriptionList(snapshot)
      );
    }

    return new Container(
      child: new Column(
        children: <Widget>[
          new Center(child: addSubscriptionForm(),),
          subscriptionListPage(),
        ],
      ),
    );
  }



  Widget buildSubscriptionList(AsyncSnapshot<List<SubscriptionItem>> snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return new CircularProgressIndicator();
      default:
        if(snapshot.hasError)
          return new Text("サーバーからの応答がないためリストを取得できません");
        subItems = snapshot.data;
        return new Flexible(
          child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) => _createSubscription(index),
              itemCount: subItems.length
          ),
        );
    }
  }

  Widget simpleSnackBar(String content) {
    return new SnackBar(content: Text(content));
  }

  Widget _createSubscription(int index) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(subItems[index].content),
          subtitle: new Text(subItems[index].type),
        ),
        new Divider(height: 5.0,)
      ],
    );
  }
}
