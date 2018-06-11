import 'package:flutter/material.dart';
import 'package:boono_mobile/model/subscription_item.dart';

class AddSubscriptionItemPage extends StatefulWidget {
  @override
  _AddSubscriptionItemPageState createState() => new _AddSubscriptionItemPageState();
}

class _AddSubscriptionItemPageState extends State<AddSubscriptionItemPage> {

  String _content;
  String _type = 'TitleItem';
  bool onCustomKeyboard = false;

  List<SubscriptionItem> subItems;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(listener);
  }

  void listener(){
    if(focusNode.hasFocus){
      setState(() {
        onCustomKeyboard = true;
      });
    }
    else
      setState(() {
        onCustomKeyboard = false;
      });
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

    //rebuildのために追加
    setState(() => null);
  }


  @override
  Widget build(BuildContext context) {

    void _submit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        saveSubscriptionItem();
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
                  focusNode: focusNode,
                  decoration: InputDecoration(hintText: '購読リスト追加',),
                  controller: _controller,
                  validator: (val) => val.isNotEmpty ? null : 'なにか入力してください！',
                  onSaved: (val) { _content = val; },
                  onFieldSubmitted:(_) => _submit(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget selectTypeForm() {
      return Row(
        children: <Widget>[
          Text('リストのタイプを選択'),
          Padding(padding: EdgeInsets.all(10.0),),
          IconButton(
            tooltip: '本',
            icon: Icon(Icons.book),
            onPressed: () => _type = 'TitleItem',
            color: Colors.blueAccent,
          ),
          IconButton(
            tooltip: '作者',
            icon: Icon(Icons.account_circle),
            onPressed: () => _type = 'AuthorItem',
            color: Colors.blueAccent,
          ),
        ],
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
          new Offstage(
            offstage: !onCustomKeyboard,
            child: selectTypeForm(),
          )
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
        const Divider(height: 5.0,)
      ],
    );
  }
}
