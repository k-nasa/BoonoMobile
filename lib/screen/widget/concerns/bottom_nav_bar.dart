import 'package:flutter/material.dart';

import 'package:boono_mobile/screen//add_description_list.dart';
import 'package:boono_mobile/screen/notify_book_list_view.dart';
import 'package:boono_mobile/screen/setting_screen.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<Widget> _pages;

  List<Widget> pages (){
    return [
      NotifyBookListViewScreen(),
      AddSubscriptionItemPage(),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {

    List <BottomNavigationBarItem> botNavBarList = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        title: Text('タイムライン'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('リスト追加'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.unarchive),
        title: Text('設定'),
      ),
    ];

    _pages = pages();

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

    // ignore: prefer_const_constructors
    Widget appBar = PreferredSize(child: AppBar(), preferredSize: Size(0.0, 0.0));

    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: botNavBar,
    );
  }
}
