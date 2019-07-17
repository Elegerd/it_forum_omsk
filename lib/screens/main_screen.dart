import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/schedule.dart' as schedule;
import 'package:it_forum_omsk/screens/my_schedule.dart' as my_schedule;
import 'package:it_forum_omsk/screens/speaker.dart' as speaker;
import 'package:it_forum_omsk/screens/about.dart' as about;
import 'package:it_forum_omsk/screens/map.dart' as map;


class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _currentIndex = 0;

  var items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.filter),
        title: Text('About'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_outline),
      title: Text('Speaker'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text('Map'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time),
      title: Text('Schedule'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star_border),
      title: Text('MySchedule'),
    ),
  ];

  Widget callPage(int currentIndex) {
    switch(currentIndex) {
      case 0:
        return about.About('О форуме');
      case 1:
        return speaker.Speaker('Спикеры');
      case 2:
        return map.Map('Место проведения');
      case 3:
        return schedule.Schedule('Программа');
      case 4:
        return my_schedule.MySchedule('Моё расписание');
      default:
        return about.About('О форуме');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: items,
        ),
        body: callPage(_currentIndex),
    );
  }
}