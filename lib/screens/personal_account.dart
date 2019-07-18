import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/custom_appbar_v2.dart';

class PersonalAccount extends StatelessWidget {
  final String title;
  PersonalAccount(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar(title),
        ],
      ),
    );
  }
}