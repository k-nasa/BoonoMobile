import 'package:flutter/material.dart';

import 'package:boono_mobile/page/add_description_list.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.notifications),
        title: 'タイムライン',
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.add),
        title: 'リスト追加',
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.unarchive),
        title: '設定',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
    });
  }

  Widget _buildTransitionsStack() {
    return new Stack(
      children: <Widget>[
        new Offstage(
          offstage: _currentIndex != 0,
          child: new TickerMode(
            enabled: _currentIndex== 0,
            child: new Text('first page!!'),
          ),
        ),
        new Offstage(
          offstage: _currentIndex != 1,
          child: new TickerMode(
            enabled: _currentIndex == 1,
            child: new AddDescriptionPage(),
          ),
        ),
        new Offstage(
          offstage: _currentIndex != 2,
          child: new TickerMode(
            enabled: _currentIndex == 2,
            child: new Text('therd page!!'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List <BottomNavigationBarItem> botNavBarList = _navigationViews
        .map((NavigationIconView navigationView) => navigationView.item)
        .toList();

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: botNavBarList,
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      //appBar: new AppBar(
      //  title: new Text('BoonoMobile'),
      //  backgroundColor: _navigationViews[_currentIndex]._color,
      //),
      body: _buildTransitionsStack(),
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync
  }) : _color = color,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final BottomNavigationBarItem item;
  final Color _color;
  final AnimationController controller;
  CurvedAnimation _animation;
}
