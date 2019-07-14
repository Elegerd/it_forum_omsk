import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:it_forum_omsk/models/model_event.dart';


@immutable
abstract class EventState extends Equatable {
  EventState([List props = const []]) : super(props);
}

class EventsLoading extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded(this.events) : super([events]);
}