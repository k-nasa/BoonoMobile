import 'package:flutter/material.dart';
import 'package:boono_mobile/model/notify_book.dart';
import 'package:boono_mobile/bloc/notify_book_bloc.dart';
import 'package:boono_mobile/screen/notify_book_detail.dart';
import 'package:boono_mobile/model/new_info.dart';
import 'package:boono_mobile/bloc/notify_book_bloc_provider.dart';

class NotifyBookListViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NotifyBookBlocProvider(
      key: GlobalKey(),
      notifyBookBloc: new NotifyBookBloc(),
      child: new Center(
        child: new NotifyBookListView(),
      ),
    );
  }
}

class NotifyBookListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotifyBookBloc notifyBookBloc = NotifyBookBlocProvider.of(context);

    return StreamBuilder<bool>(
      stream: notifyBookBloc.isRebuildListView,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          RefreshIndicator(
            onRefresh: () async {
              await NewInfo.fetchNewInfo();
              notifyBookBloc.rebuildListView.add(true);
              return null;
            },
            child: FutureBuilder(
              future: NotifyBook.all(),
              builder: (context, snapshot) => buildNotifyBookList(context, snapshot),
            ),
          ),
    );
  }

  Widget buildNotifyBookList(BuildContext context,AsyncSnapshot snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return const CircularProgressIndicator();
      default:
        if(snapshot.hasError){
          ()async {
            await NewInfo.updateNewInfo(true);
            final NotifyBookBloc notifyBookBloc = NotifyBookBlocProvider.of(context);
            Scaffold.of(context).showSnackBar(const SnackBar(content: Text('エラーのため再読込します')));
            notifyBookBloc.rebuildListView.add(true);
          };
        }
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) => NotifyBookListItem(snapshot.data[index]),
            itemCount: snapshot.data.length
        );
    }
  }
}

class NotifyBookListItem extends StatefulWidget {
  NotifyBook notifyBook;

  NotifyBookListItem(this.notifyBook);
  @override
  _NotifyBookListItemState createState() => new _NotifyBookListItemState(notifyBook);
}

class _NotifyBookListItemState extends State<NotifyBookListItem> {

  NotifyBook notifyBook;
  bool onDisplay = true;

  _NotifyBookListItemState(this.notifyBook);

  @override
  Widget build(BuildContext context) {
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
          setState(() { onDisplay = false; });

          if(!await notifyBook.delete()){
            final NotifyBookBloc notifyBookBloc = NotifyBookBlocProvider.of(context);
            Scaffold.of(context).showSnackBar(const SnackBar(content: Text('削除に失敗しました')));
            notifyBookBloc.rebuildListView.add(true);
          }
          setState(() {
            onDisplay = false;
          });
        },
        child: onDisplay ? conteiner : Container()
    );
  }
}
