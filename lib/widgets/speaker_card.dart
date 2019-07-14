import 'package:flutter/material.dart';


class SpeakerCard extends StatelessWidget {
  final speaker;
  final int size;

  SpeakerCard(this.speaker, this.size);
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
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white30,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage("assets/avatars/speaker-${speaker.id}.png"),
                        radius: 97,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("${speaker.lastName} ${speaker.firstName}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, fontFamily: 'Roboto', color: Colors.white),),
                    Text("${speaker.middleName}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, fontFamily: 'Roboto', color: Colors.white),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}