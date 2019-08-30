import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/login_page.dart';
import 'package:it_forum_omsk/screens/map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MoreList extends StatefulWidget {
  @override
  _MoreList createState() => _MoreList();
}

class _MoreList extends State<MoreList> {

  FirebaseUser currentUser;
  var items;

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const borderColor = Color.fromRGBO(124, 125, 141, 1);
  static const contentColor = Color.fromRGBO(31, 32, 65, 0.8);
  static const contentStyle = TextStyle(fontWeight: FontWeight.w400, color: contentColor, fontSize: 16);

  logout() {
    FirebaseAuth.instance.signOut()
        .then((e) => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()
            ),
          )
        })
        .catchError((err) => print(err));
  }

  pageRoute() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Map('Место проведения')
      ),
    );
  }

  @override
  void initState() {
    items = [
      Content(SvgPicture.asset("assets/menu_icons/person.svg", color: contentColor, height: 30, width: 30,), "Личный кабинет", null),
      Content(SvgPicture.asset("assets/menu_icons/info.svg", color: contentColor, height: 30, width: 30,), "О форуме", null),
      Content(SvgPicture.asset("assets/menu_icons/map.svg", color: contentColor, height: 30, width: 30,), "Место проведения", pageRoute),
      Content(SvgPicture.asset("assets/menu_icons/social.svg", color: contentColor, height: 30, width: 30,), "Социальные сети", null),
      Content(SvgPicture.asset("assets/menu_icons/hand.svg", color: contentColor, height: 30, width: 30,), "Партнёры", null),
      Content(SvgPicture.asset("assets/menu_icons/logout.svg", color: contentColor, height: 30, width: 30,), "Выйти из аккаунта", logout),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Container _container(iconData, String title, index) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: borderColor,),
          top: BorderSide(width: index == 0 ? 1 : 0, color: borderColor,),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: iconData,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(title, style: contentStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: _container(items[index].iconData, items[index].title, index),
          onTap: items[index].fun,
        );
      }
    );
  }
}

class Content {
  final iconData;
  final fun;
  String title;
  Content(this.iconData, this.title, this.fun);
}