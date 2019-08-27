import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/custom_tabbar.dart';
import 'package:it_forum_omsk/widgets/event_card.dart';
import 'package:it_forum_omsk/widgets/event_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SpeakerNote extends StatefulWidget {
  final int idSpeaker;
  final speaker;
  SpeakerNote(this.speaker, this.idSpeaker);

  @override
  _SpeakerNote createState() => _SpeakerNote();
}

class _SpeakerNote extends State<SpeakerNote> with SingleTickerProviderStateMixin {

  TabController tabController;
  List<Tab> tabs;

  static const contentColor = Color.fromRGBO(31, 32, 65, 0.8);
  static const titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: contentColor);
  static const tabStyle = TextStyle(fontFamily: 'Roboto', fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    tabs = [
      Tab(
        child: Text('Информация',
          style: tabStyle
        ),
      ),
      Tab(
        child: Text('Выступления',
          style: tabStyle
        ),
      ),
      Tab(
        child: Text('Презентации',
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
    return Container(
      child: Column(
        children: <Widget>[
          customTabBar(tabs, tabController),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  children: <Widget>[
                    Text(widget.speaker['note'] ?? "", style: titleStyle,),
                  ],
                ),
                StreamBuilder<QuerySnapshot> (
                    stream: Firestore.instance.collection('events').snapshots(),
                    builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          var events = [];
                          for (var document in snapshot.data.documents) {
                            for(var event in document.data['array_events']){
                              if (event['id_speaker'] == widget.idSpeaker) {
                                events.add(event);
                              }
                            }
                          }
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            scrollDirection: Axis.vertical,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: EventContainer(events[index]),
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventCard(events[index]),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                      }
                    }
                ),
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  children: <Widget>[
                    Text(widget.speaker['note'] ?? "", style: titleStyle,),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}