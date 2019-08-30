import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/event_container.dart';
import 'package:it_forum_omsk/widgets/event_card.dart';
import 'package:it_forum_omsk/widgets/custom_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class EventFavouriteList extends StatefulWidget {
  @override
  _EventFavouriteList createState() => _EventFavouriteList();
}

class _EventFavouriteList extends State<EventFavouriteList> with SingleTickerProviderStateMixin {

  var uid;
  TabController tabController;
  List<Tab> tabs;

  static const mainColor = Color.fromRGBO(50, 21, 121, 1);
  static const tabStyle = TextStyle(fontFamily: 'Roboto', fontSize: 16.0);

  @override
  void initState() {
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
    super.initState();
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
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
          if (!user.hasData) {
            return Center(
              child: SpinKitPulse(
                color: mainColor,
                size: 10.0,
              ),
            );
          }
          else {
            uid = user.data.uid;
            return Column(
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
              );
          }
        }
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> buildStreamBuilder(document) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(uid)
            .collection('featured_events')
            .document(document).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> favouriteSnapshot) {
          switch (favouriteSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: SpinKitPulse(
                  color: mainColor,
                  size: 10.0,
                ),
              );
            default:
              if (favouriteSnapshot.data.data == null) {
                return SizedBox();
              }
              else {
              var favourite = [];
              favouriteSnapshot.data.data.forEach((k, v) =>
              {
                if(v['favourite'] == true) {
                  favourite.add(int.parse(k))
                },
              });
                return StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection('events').document(
                      document).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: SpinKitPulse(
                            color: mainColor,
                            size: 10.0,
                          ),
                        );
                      default:
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: favourite.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data
                                  .data['array_events'][favourite[index]];
                              var documentId = snapshot.data.documentID;
                              return GestureDetector(
                                child: EventContainer(data),
                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventCard(
                                              favourite[index], documentId,
                                              data),
                                    ),
                                  );
                                },
                              );
                            }
                        );
                    }
                  },
                );
              }
          }
        }
    );
  }
}