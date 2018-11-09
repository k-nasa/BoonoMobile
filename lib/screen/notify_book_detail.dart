import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


@immutable
class Detail extends StatelessWidget {
  const Detail(this.notifyBook);
  final NotifyBook notifyBook;

  @override
  Widget build(BuildContext context) {
    Widget appBar =
        PreferredSize(child: AppBar(), preferredSize: Size(0.0, 0.0));

    TextStyle captionTextStyle = Theme.of(context).textTheme.display4;
    TextStyle defaultTextStyle = Theme.of(context).textTheme.display3;

    if (notifyBook.synopsis.isEmpty) notifyBook.synopsis = '情報なし';

    return new MaterialApp(
        title: 'Flutter Demo',
        theme: Theme.of(context),
        home: new Scaffold(
            appBar: appBar,
            backgroundColor: Theme.of(context).backgroundColor,
            body: new CustomScrollView(slivers: <Widget>[
              new SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).backgroundColor,
                expandedHeight: 500.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadeInImage(
                    placeholder: AssetImage('assets/images/now-loading.png'),
                    image: NetworkImage(notifyBook.bigImageUrl),
                  ),
                ),
              ),
              // FIXME リファクタ
              SliverList(
                  delegate: SliverChildListDelegate([
                Text(
                  notifyBook.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Text('著者', style: captionTextStyle),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(notifyBook.author, style: defaultTextStyle),
                ),
                Text(
                  '発売日',
                  style: captionTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    notifyBook.publishDate,
                    style: defaultTextStyle,
                  ),
                ),
                Text(
                  '金額',
                  style: captionTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(notifyBook.amount, style: defaultTextStyle),
                ),
                Text('あらすじ', style: captionTextStyle),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(notifyBook.synopsis, style: defaultTextStyle),
                ),

                FlatButton(
                  child: Text('amazonで開く', style: captionTextStyle,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<Null>(
                            settings: const RouteSettings(name: '/web_view'),
                            builder: (BuildContext context) =>
                                WebviewScaffold(
                                  appBar: AppBar(),
                                  url: notifyBook.detailUrl,
                                )
                        ));
                  },
                )
              ])),
            ])
        )
    );
  }
}
