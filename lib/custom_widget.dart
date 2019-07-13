import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  final String title;
  final int size;
  final keyStay;

  CustomAppBar(this.title, this.size, this.keyStay);
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
            leading: Padding(
              padding: EdgeInsets.only(left: 20),
              child: IconButton(
                icon: const Icon(Icons.format_list_bulleted, size: 28,),
                onPressed: () {
                  keyStay.openDrawer();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

Widget customTabBar(List<Tab> tabs, var tabController){
  return TabBar(
    controller: tabController,
    indicatorColor: Color.fromRGBO(69, 69, 77, 0.8),
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorWeight: 3.0,
    isScrollable: true,
    labelColor: Color.fromRGBO(69, 69, 77, 0.8),
    labelStyle: TextStyle(fontWeight: FontWeight.w800),
    unselectedLabelColor: Color.fromRGBO(69, 69, 77, 0.8),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    tabs: tabs,
  );
}