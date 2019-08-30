import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/speaker_list.dart';


class Speaker extends StatelessWidget {
  final String title;
  Speaker(this.title);

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
            padding: EdgeInsets.only(top: 25),
            child: Text(title,
              style: TextStyle(color: appTitleColor, fontSize: 24),
            ),
          ),
        ),
      ),
      body: SpeakerList(),
    );
  }
}
