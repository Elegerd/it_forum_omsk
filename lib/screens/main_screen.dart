import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it_forum_omsk/screens/more.dart';
import 'package:it_forum_omsk/screens/schedule.dart';
import 'package:it_forum_omsk/screens/my_schedule.dart';
import 'package:it_forum_omsk/screens/speaker.dart';
import 'package:it_forum_omsk/screens/news.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  int _currentIndex;
  var items;

  static const selectedColor = Color.fromRGBO(52, 152, 219, 1);
  static const bottomNavColor = Color.fromRGBO(50, 21, 121, 1);

  Widget callPage(int currentIndex) {
    switch(currentIndex) {
      case 0:
        return Speaker('Спикеры форума');
      case 1:
        return Schedule('Программа форума');
      case 2:
        return MySchedule('Моё расписание');
      case 3:
        return News('Новости');
      case 4:
        return More('Другие пункты');
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    items = [
      _getNavItem('Спикеры', 'assets/menu_icons/speaker.svg'),
      _getNavItem('Программа', 'assets/menu_icons/clock.svg'),
      _getNavItem('Моё расписание', 'assets/menu_icons/star.svg'),
      _getNavItem('Новости', 'assets/menu_icons/news.svg'),
      _getNavItem('Ещё', 'assets/menu_icons/more.svg'),
    ];
  }

  BottomNavigationBarItem _getNavItem(title, path) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(path, color: Colors.white, height: 23, width: 23,),
      activeIcon: SvgPicture.asset(path, color: selectedColor, height: 23, width: 23,),
      title: Text(title, style: TextStyle(fontSize: 14),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: bottomNavColor,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: items,
          selectedItemColor: selectedColor,
        ),
      ),
      body: callPage(_currentIndex),
    );
  }
}