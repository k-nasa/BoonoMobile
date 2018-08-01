import 'package:flutter/material.dart';

import 'package:boono_mobile/screen//add_description_list.dart';
import 'package:boono_mobile/screen/notify_book_list_view.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  Color navColor;
  List<NavigationIconView> _navigationViews;
  List<Widget> _pages;

  List<Widget> pages (){
    return [
      new NotifyBookListViewScreen(),
      new AddSubscriptionItemPage(),
      //new Text('third'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    navColor = Theme.of(context).primaryColor;

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.notifications),
        title: 'タイムライン',
        color: navColor,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.add),
        title: 'リスト追加',
        color: navColor,
      ),
      // TODO 設定画面をあとから足す予定なのでコメントアウトして残しておく
      //new NavigationIconView(
      //  icon: const Icon(Icons.unarchive),
      //  title: '設定',
      //  color: navColor,
      //  vsync: this,
      //)
    ];

    _pages = pages();

    List <BottomNavigationBarItem> botNavBarList = _navigationViews
        .map((NavigationIconView navigationView) => navigationView.item)
        .toList();

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: botNavBarList,
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    Widget appBar = PreferredSize(child: AppBar(), preferredSize: Size(0.0, 0.0));

    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
  }) : item = new BottomNavigationBarItem(
    icon: icon,
    title: new Text(title),
    backgroundColor: color,
  );

  final BottomNavigationBarItem item;
  final AnimationController controller;
}
