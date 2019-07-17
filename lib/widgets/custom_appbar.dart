import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  final String title;
  final int size;

  CustomAppBar(this.title, this.size);
  @override
  Widget build(BuildContext context) {
    final double statusBarSize = MediaQuery.of(context).padding.top;
    return Material(
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.only(top: statusBarSize),
        height: statusBarSize + size,
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
          child: AppBar(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}