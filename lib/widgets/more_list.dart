import 'package:flutter/material.dart';


class MoreList extends StatefulWidget {
  @override
  _MoreList createState() => _MoreList();
}

class _MoreList extends State<MoreList> {

  var items;

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const borderColor = Color.fromRGBO(124, 125, 141, 1);
  static const contentColor = Color.fromRGBO(31, 32, 65, 0.8);
  static const contentStyle = TextStyle(fontWeight: FontWeight.w400, color: contentColor, fontSize: 16);

  @override
  void initState() {
    items = [
      Content(Icons.person, "Личный кабинет"),
      Content(Icons.info_outline, "О форуме"),
      Content(Icons.map, "Место проведения"),
      Content(Icons.pan_tool, "Партнёры"),
      Content(Icons.speaker_notes, "Социальные сети"),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Container _container(IconData iconData, String title, index) {
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
            child: Icon(iconData, color: iconColor, size: 28,),
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
        return _container(items[index].iconData, items[index].title, index);
      }
    );
  }
}

class Content {
  IconData iconData;
  String title;
  Content(this.iconData, this.title);
}