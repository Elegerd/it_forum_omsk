import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/custom_appbar_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Schedule extends StatelessWidget{
  final String title;
  Schedule(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar("$title форума"),
          Expanded(child: EventList()),
        ],
      ),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> with SingleTickerProviderStateMixin {

  TabController tabController;

  List<Tab> tabs = [
    Tab(
      child: Text(
        '23 октября',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        '24 октября',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        '25 октября',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync:  this, length: tabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _eventContainer(String name, String location, String timeSpending) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8)),
        child: Container(
          height: 80,
          color: Color.fromRGBO(224, 224, 224, 1),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(name),
              ),
              Padding(
                padding: EdgeInsets.only(top: 45, left: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.schedule, color: Color.fromRGBO(31, 32, 65, 0.8), size: 28,),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 2),
                      child: Container(
                        width: 100,
                        child: Text(timeSpending, style: TextStyle(fontWeight: FontWeight.w400),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20),
                      child: Text(location, style: TextStyle(fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TabBar(
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
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection('events').document('day_1').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return ListView(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                var i = index + 1;
                                var data = snapshot.data.data['$i'];
                                return _eventContainer(
                                    data['name'],
                                    data['location'],
                                    data['timeSpending']);
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection('events').document('day_2').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return ListView(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                var i = index + 1;
                                var data = snapshot.data.data['$i'];
                                return _eventContainer(
                                    data['name'],
                                    data['location'],
                                    data['timeSpending']);
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection('events').document('day_3').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return ListView(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                var i = index + 1;
                                var data = snapshot.data.data['$i'];
                                return _eventContainer(
                                    data['name'],
                                    data['location'],
                                    data['timeSpending']);
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}