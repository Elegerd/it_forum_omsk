import 'package:flutter/material.dart';


class MySchedule extends StatelessWidget{
  final String title;
  MySchedule(this.title);

  static const appTitleColor = Color.fromRGBO(69, 69, 77, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(title,
              style: TextStyle(color: appTitleColor, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}