import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/event_container.dart';
import 'package:it_forum_omsk/widgets/event_card.dart';
import 'package:it_forum_omsk/widgets/custom_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventList extends StatefulWidget {
  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> with SingleTickerProviderStateMixin {

  TabController tabController;
  List<Tab> tabs;

  static const tabStyle = TextStyle(fontFamily: 'Roboto', fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    tabs = [
      Tab(
        child: Text('23 октября',
          style: tabStyle
        ),
      ),
      Tab(
        child: Text('24 октября',
          style: tabStyle
        ),
      ),
      Tab(
        child: Text('25 октября',
          style: tabStyle
        ),
      ),
    ];
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: customTabBar(tabs, tabController),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                buildStreamBuilder('document_events_0'),
                buildStreamBuilder('document_events_1'),
                buildStreamBuilder('document_events_2'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> buildStreamBuilder(document) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('events').document(document).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.data['array_events'].length,
              itemBuilder: (context, index) {
                var data = snapshot.data.data['array_events'][index];
                return GestureDetector(
                  child: EventContainer(data),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => EventCard(data),
                      ),
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}