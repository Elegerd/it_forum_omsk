import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_forum_omsk/blocs/speaker_bloc.dart';
import 'package:it_forum_omsk/blocs/speaker_event.dart';
import 'package:it_forum_omsk/blocs/speaker_state.dart';
import 'package:it_forum_omsk/blocs/event_bloc.dart';
import 'package:it_forum_omsk/blocs/event_event.dart';
import 'package:it_forum_omsk/blocs/event_state.dart';
import 'package:it_forum_omsk/widgets/event_container.dart';
import 'package:it_forum_omsk/widgets/speaker_container.dart';
import 'package:it_forum_omsk/widgets/custom_appbar_v2.dart';
import 'package:it_forum_omsk/widgets/speaker_card.dart';
import 'package:it_forum_omsk/widgets/custom_tabbar.dart';



class Speaker extends StatelessWidget {

  final String title;
  Speaker(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar(title/*, 100*/),
          Expanded(
            child: BlocProvider(
              builder: (_context) => SpeakerBloc(),
              child: SpeakerList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SpeakerList extends StatefulWidget {
  @override
  _SpeakerList createState() => _SpeakerList();
}

class _SpeakerList extends State<SpeakerList> {

  SpeakerBloc _eventBloc;

  @override
  void initState() {
    super.initState();
    // Obtaining the EventBloc instance through BlocProvider which is an InheritedWidget
    _eventBloc = BlocProvider.of<SpeakerBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    // We want to start loading fruits right from the start.
    _eventBloc.dispatch(InitSpeakers());
    _eventBloc.dispatch(LoadSpeakers());
  }

  @override
  void dispose() {
    _eventBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _eventBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, SpeakerState state) {
        if (state is SpeakersLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SpeakersLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.speakers.length,
            itemBuilder: (context, index) {
              final displayedSpeaker = state.speakers[index];
              return GestureDetector(child: SpeakerContainer(displayedSpeaker, _eventBloc), onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      Column(
                        children: <Widget>[
                          SpeakerCard(displayedSpeaker, 300),
                          Expanded(
                            child: BlocProvider(
                              builder: (_context) => EventBloc(),
                              child: DetailPage(displayedSpeaker),
                            ),
                          )
                        ],
                      ),
                  ),
                );
              });
            },
          );
        }
        else {
          return null;
        }
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  final speaker;
  DetailPage(this.speaker);

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> with SingleTickerProviderStateMixin {

  TabController tabController;
  EventBloc _eventBloc;

  List<Tab> tabs = [
    Tab(
      child: Text(
        'Информация',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Выступления',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Презентации',
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
    tabController = TabController(vsync: this, length: tabs.length);
    _eventBloc = BlocProvider.of<EventBloc>(context);
    _eventBloc.dispatch(InitEvents());
    _eventBloc.dispatch(LoadSpeakerEvents(widget.speaker.idEvent));
  }

  @override
  void dispose() {
    tabController.dispose();
    _eventBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            customTabBar(tabs, tabController),
            BlocBuilder(
              bloc: _eventBloc,
              builder: (BuildContext context, EventState state) {
                if (state is EventsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is EventsLoaded) {
                  return Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: <Widget>[
                        Center(
                          child: Text(widget.speaker.note),
                        ),
                        ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final displayedEvent = state.events[index];
                            return EventContainerNoButton(displayedEvent, _eventBloc);
                          },
                        ),
                        Center(
                          child: Text('Презентации'),
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
        )
    );
  }
}
