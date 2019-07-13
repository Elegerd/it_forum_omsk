import 'package:flutter/material.dart';
import 'package:it_forum_omsk/bloc/event_bloc.dart';
import 'package:it_forum_omsk/bloc/event_event.dart';
import 'package:it_forum_omsk/database/model.dart';


class EventContainer extends StatelessWidget {
  final Event event;
  final EventBloc bloc;
  final bool favorite;
  const EventContainer(this.event, this.bloc, this.favorite);

  Widget _buildMenu(Event event, EventBloc bloc, context) {
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
                child: Text(event.nameEvent),
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
                        child: Text(event.timeSpending, style: TextStyle(fontWeight: FontWeight.w400),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20),
                      child: Text(event.location, style: TextStyle(fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: MediaQuery.of(context).size.width - 95),
                child: IconButton(
                  icon: event.chosen?
                  Icon(Icons.check_circle_outline, size: 50, color: Color.fromRGBO(31, 32, 65, 0.8)) :
                  Icon(Icons.radio_button_unchecked, size: 50, color: Color.fromRGBO(31, 32, 65, 0.8)),
                  onPressed: () {
                    bloc.dispatch(ModifyEvent(event));
                    if (favorite) {
                      bloc.dispatch(LoadFavoriteEvents());
                    }
                  },
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
    return _buildMenu(this.event, this.bloc, context);
  }
}

class EventContainerNoButton extends StatelessWidget {
  final Event event;
  final EventBloc bloc;
  const EventContainerNoButton(this.event, this.bloc);

  Widget _buildMenu(Event event, EventBloc bloc, context) {
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
                child: Text(event.nameEvent),
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
                        child: Text(event.timeSpending, style: TextStyle(fontWeight: FontWeight.w400),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20),
                      child: Text(event.location, style: TextStyle(fontWeight: FontWeight.w400),),
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
    return _buildMenu(this.event, this.bloc, context);
  }
}