import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_forum_omsk/bloc/event_bloc.dart';
import 'package:it_forum_omsk/bloc/event_event.dart';
import 'package:it_forum_omsk/bloc/event_state.dart';
import 'package:it_forum_omsk/schedule/event_container.dart';
import 'package:it_forum_omsk/custom_widget.dart';


class MySchedule extends StatelessWidget{
  final String title;
  final keyState;
  MySchedule(this.title, this.keyState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar(title, 100, keyState),
          Expanded(
            child: BlocProvider(
              builder: (_context) => EventBloc(),
              child: FavoriteEventList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteEventList extends StatefulWidget {
  @override
  _FavoriteEventList createState() => _FavoriteEventList();
}

class _FavoriteEventList extends State<FavoriteEventList> with SingleTickerProviderStateMixin {

  EventBloc _eventBloc;

  @override
  void initState() {
    super.initState();
    // Obtaining the EventBloc instance through BlocProvider which is an InheritedWidget
    _eventBloc = BlocProvider.of<EventBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    // We want to start loading fruits right from the start.
    _eventBloc.dispatch(InitEvents());
    _eventBloc.dispatch(LoadFavoriteEvents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _eventBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, EventState state) {
        if (state is EventsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventsLoaded) {
          return ListView.builder (
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              final displayedEvent = state.events[index];
              return EventContainer(displayedEvent, _eventBloc, true);
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