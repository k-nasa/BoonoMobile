import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';

class Detail extends StatelessWidget{
  final NotifyBook notifyBook;

  Detail(this.notifyBook);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blue),
        home: new Scaffold(
          body: Center(child: Text(notifyBook.title)),
        )
    );
  }
}
