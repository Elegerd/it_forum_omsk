import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_forum_omsk/blocs/event_bloc.dart';
import 'package:it_forum_omsk/blocs/event_event.dart';
import 'package:it_forum_omsk/blocs/event_state.dart';
import 'package:it_forum_omsk/widgets/event_container.dart';
import 'package:it_forum_omsk/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Schedule extends StatelessWidget{
  final String title;
  final keyState;
  Schedule(this.title, this.keyState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar("$title форума", 100, keyState),
          Expanded(
            child: BlocProvider(
              builder: (_context) => EventBloc(),
              child: EventList(),
            ),
          ),
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
  EventBloc _eventBloc;

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
    // Obtaining the EventBloc instance through BlocProvider which is an InheritedWidget
    _eventBloc = BlocProvider.of<EventBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    _eventBloc.dispatch(InitEvents());
    _eventBloc.dispatch(LoadEvents(tabController.index + 1));
  }

  @override
  void dispose() {
    tabController.dispose();
    _eventBloc.dispose();
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
            onTap: (index) {
              tabController.animateTo((tabController.index));
              setState(() {
                _eventBloc.dispatch(LoadEvents(tabController.index + 1));
              });
            },
          ),
          BlocBuilder(
            bloc: _eventBloc,
            // Whenever there is a new state emitted from the bloc, builder runs.
            builder: (BuildContext context, EventState state) {
              if (state is EventsLoading) {
                return Center(
                    child: SizedBox(
                      height: 50, child: CircularProgressIndicator(),
                    ),
                );
              } else if (state is EventsLoaded) {
                return Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
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
                      Container(
                        child: ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final displayedEvent = state.events[index];
                            return EventContainer(displayedEvent, _eventBloc, false);
                          },
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final displayedEvent = state.events[index];
                            return EventContainer(displayedEvent, _eventBloc, false);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }
}