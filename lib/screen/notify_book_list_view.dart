import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:boono_mobile/bloc/notify_book_bloc.dart';
import 'package:boono_mobile/screen/notify_book_detail.dart';
import 'package:boono_mobile/model/new_info.dart';

class NotifyBookListViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new NotifyBookListView(),
    );
  }
}

class NotifyBookListView extends StatelessWidget {
  NotifyBookBloc notifyBookBloc = NotifyBookBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: notifyBookBloc.isRebuildListView,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          RefreshIndicator(
            onRefresh: () async {
              await NewInfo.fetchNewInfo();
              if(await NewInfo.new_info())
                notifyBookBloc.rebuildListView.add(true);
              return null;
            },
            child: FutureBuilder(
              future: NotifyBook.all(),
              builder: (_, snapshot) => buildNotifyBookList(snapshot),
            ),
          ),
    );
  }

  Widget buildNotifyBookList(AsyncSnapshot snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return const CircularProgressIndicator();
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
    NotifyBook notifyBook = snapshot.data[index];

    Widget conteiner = Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(notifyBook.image_url),
          ),
          title: Text(notifyBook.title),
          subtitle: Text('${notifyBook.author}\n${notifyBook.publish_date}'),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute<Null>(
                settings: const RouteSettings(name: "/detail"),
                builder: (BuildContext context) => new Detail(notifyBook)
            ));
          },
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
