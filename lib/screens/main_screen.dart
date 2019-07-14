import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:it_forum_omsk/screens/schedule.dart' as schedule;
import 'package:it_forum_omsk/screens/my_schedule.dart' as my_schedule;
import 'package:it_forum_omsk/screens/speaker.dart' as speaker;
import 'package:it_forum_omsk/screens/about.dart' as about;
import 'package:it_forum_omsk/screens/map.dart' as map;


class MenuItem {
  MenuItem(this.title, this.icon);
  final String title;
  final Icon icon;
}

final List<MenuItem> menuItems = <MenuItem>[
  MenuItem('О форуме', Icon(Icons.info_outline, size: 30, color: Colors.white,)),
  MenuItem('Программа', Icon(Icons.schedule, size: 30, color: Colors.white,)),
  MenuItem('Профиль', Icon(Icons.perm_identity, size: 30, color: Colors.white,)),
  MenuItem('Моё расписание', Icon(Icons.star_border, size: 30, color: Colors.white,)),
  MenuItem('Спикеры', Icon(Icons.people_outline, size: 30, color: Colors.white,)),
  MenuItem('Место проведения', Icon(Icons.location_on, size: 30, color: Colors.white,)),
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

StatelessWidget widget;

class _MainScreen extends State<MainScreen> {

  var _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    widget = about.About(menuItems[0].title, _scaffoldKey.currentState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sidemenu-background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromRGBO(74, 20, 140, 0.7), const Color.fromRGBO(74, 20, 140, 0.580), const Color.fromRGBO(74, 20, 140, 0.7),],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  tileMode: TileMode.clamp,
                ),
              ),
              child: ListView(
                children: <Widget> [
                  DrawerHeader(
                    child: Center(
                      child: CircleAvatar(
                        child: Text("IT-FORUM", style: TextStyle(fontSize: 25),),
                        backgroundColor: Colors.white,
                        radius: 80,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    title: Text(menuItems[0].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                    leading: menuItems[0].icon,
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        widget = about.About(menuItems[0].title, _scaffoldKey.currentState);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    title: Text(menuItems[1].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                    leading: menuItems[1].icon,
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        widget = schedule.Schedule(menuItems[1].title, _scaffoldKey.currentState);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    title: Text(menuItems[3].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                    leading: menuItems[3].icon,
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        widget = my_schedule.MySchedule(menuItems[3].title, _scaffoldKey.currentState);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    title: Text(menuItems[4].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                    leading: menuItems[4].icon,
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        widget = speaker.Speaker(menuItems[4].title, _scaffoldKey.currentState);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    title: Text(menuItems[5].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                    leading: menuItems[5].icon,
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        widget = map.Map(menuItems[5].title, _scaffoldKey.currentState);
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => launch('https://vk.com/itsiberia'),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Container(
                              width: 40.0,
                              height: 40.0,
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image(
                                  image: AssetImage("assets/icons/vk-logo.png"),
                                ),
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => launch('https://www.facebook.com/groups/itsiberia/'),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Container(
                              width: 40.0,
                              height: 40.0,
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image(
                                  image: AssetImage("assets/icons/facebook-logo.png"),
                                  width: 25,
                                  height: 25,
                                ),
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => launch('https://www.instagram.com/itclaster_siberia/'),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Container(
                              width: 40.0,
                              height: 40.0,
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image(
                                  image: AssetImage("assets/icons/instagram-logo.png"),
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: widget,
        )
    );
  }
}