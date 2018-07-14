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
                      background: Image.network(
                          notifyBook.big_image_url,
                          //fit: BoxFit.cover
                      ),
                    ),
                  ),
                  // todo リファクタ
                  new SliverList(
                      delegate: new SliverChildListDelegate(
                          [
                            Text(
                              notifyBook.title,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),

                            Text('著者', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.author),
                            ),

                            Text('発売日', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.publish_date),
                            ),

                            Text('金額', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(notifyBook.amount),
                            ),

                            Text('あらすじ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
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
