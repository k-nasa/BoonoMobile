import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';

class NotifyBookListViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new NotifyBookListView(),
    );
  }
}

class NotifyBookListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotifyBook.all();
    return FutureBuilder(
      future: NotifyBook.all(),
      builder: (_, snapshot) => buildNotifyBookList(snapshot),
    );
  }

  Widget buildNotifyBookList(AsyncSnapshot snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return new CircularProgressIndicator();
      default:
        if(snapshot.hasError)
          return ListView(
            children: <Widget>[
              Text("サーバーからの応答がないためリストを取得できません"),
            ],
          );
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) => _createNotifyBook(context, index, snapshot),
            itemCount: snapshot.data.length
        );
    }
  }

  Widget _createNotifyBook(BuildContext context, int index,AsyncSnapshot snapshot){
    String title = snapshot.data[index].title;
    String author = snapshot.data[index].author;
    String publishDate = snapshot.data[index].publish_date;
    String imageUrl = snapshot.data[index].image_url;
    int notifyBookId = snapshot.data[index].id;

    NotifyBook notifyBook = new NotifyBook(id: notifyBookId);

    Widget conteiner = Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text('$author\n$publishDate'),
          onTap: () => print('TAP'),
          //trailing: Text(publishDate),
        ),
      ),
    );

    GlobalKey key = GlobalKey();

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: new Container(
        color: Colors.red,
        child: const ListTile(
          trailing: const Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (_) async{
        if(!await notifyBook.delete())
          Scaffold.of(context).showSnackBar(const SnackBar(content: Text('削除に失敗しました')));
      },
      child: conteiner
    );
  }
}
