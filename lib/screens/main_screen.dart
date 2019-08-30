import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/more.dart';
import 'package:it_forum_omsk/screens/schedule.dart';
import 'package:it_forum_omsk/screens/my_schedule.dart';
import 'package:it_forum_omsk/screens/speaker.dart';
import 'package:it_forum_omsk/screens/news.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MainScreen extends StatefulWidget {
  final String uid;
  MainScreen({Key key, this.uid}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  int _currentIndex;
  var items;
  FirebaseUser currentUser;

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  static const selectedColor = Color.fromRGBO(52, 152, 219, 1);
  static const mainColor = Color.fromRGBO(50, 21, 121, 1);

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
    this.getCurrentUser();
    _currentIndex = 0;
    items = [
      _getNavItem('Спикеры', 'assets/menu_icons/speaker.svg'),
      _getNavItem('Программа', 'assets/menu_icons/clock.svg'),
      _getNavItem('Избранное', 'assets/menu_icons/star.svg'),
      _getNavItem('Новости', 'assets/menu_icons/news.svg'),
      _getNavItem('Ещё', 'assets/menu_icons/more.svg'),
    ];
    super.initState();
  }

  BottomNavigationBarItem _getNavItem(title, path) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(path, color: Colors.white, height: 21, width: 21,),
      activeIcon: SvgPicture.asset(path, color: selectedColor, height: 21, width: 21,),
      title: Text(title, style: TextStyle(fontFamily: 'Roboto'),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: mainColor,
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
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
        ),
      ),
      body: callPage(_currentIndex),
    );
  }
}