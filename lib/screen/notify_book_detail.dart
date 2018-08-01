import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:boono_mobile/screen/styles/mainStyle.dart';

class Detail extends StatelessWidget{
  final NotifyBook notifyBook;

  Detail(this.notifyBook);

  Widget appBar = PreferredSize(child: AppBar(), preferredSize: Size(0.0, 0.0));

  @override
  Widget build(BuildContext context) {
    if (notifyBook.synopsis.isEmpty)
      notifyBook.synopsis = '情報なし';

    return new MaterialApp(
        title: 'Flutter Demo',
        theme: themeDate,
        home: new Scaffold(
            appBar: appBar,
            backgroundColor: themeDate.backgroundColor,
            body: new CustomScrollView(
                slivers: <Widget>[
                  new SliverAppBar(
                    pinned: true,
                    backgroundColor: themeDate.backgroundColor,
                    expandedHeight: 510.0,
                    flexibleSpace: new FlexibleSpaceBar(
                      // TODO オフライン時になにかに差し替える
                      // それかServerが画像データを返すようにしておく
                      background: Image.network(
                          notifyBook.big_image_url,
                      ),
                    ),
                  ),
                  // FIXME リファクタ
                  new SliverList(
                      delegate: new SliverChildListDelegate(
                          [
                            Text(
                              notifyBook.title,
                              style: Theme.of(context).textTheme.title,
                            ),

                            Text('著者', style: Theme.of(context).textTheme.display4),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.author),
                            ),

                            Text('発売日', style: Theme.of(context).textTheme.display4,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.publish_date),
                            ),

                            Text('金額', style: Theme.of(context).textTheme.display4,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.amount),
                            ),

                            Text('あらすじ', style: Theme.of(context).textTheme.display4),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.synopsis),
                            ),
                          ]
                      )
                  ),
                ]
            )
        )
    );
  }
}
