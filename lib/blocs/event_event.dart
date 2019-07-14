import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:it_forum_omsk/models/model_event.dart';


@immutable
abstract class EventEvent extends Equatable {
  EventEvent([List props = const []]) : super(props);
}

class LoadEvents extends EventEvent {
  final int idDay;
  LoadEvents(this.idDay) : super([idDay]);
}

class LoadSpeakerEvents extends EventEvent {
  final List<int> listId;
  LoadSpeakerEvents(this.listId) : super([listId]);
}

class LoadFavoriteEvents extends EventEvent {}

class InitEvents extends EventEvent {}

class UpdateEvent extends EventEvent {
  final Event updatedEvent;
  UpdateEvent(this.updatedEvent) : super([updatedEvent]);
}

class ModifyEvent extends EventEvent {
  final Event updatedEvent;
  ModifyEvent(this.updatedEvent) : super([updatedEvent]);
}

class DeleteEvent extends EventEvent {
  final Event event;
  DeleteEvent(this.event) : super([event]);
}
