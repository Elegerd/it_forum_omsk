import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:it_forum_omsk/database/model.dart';


@immutable
abstract class SpeakerEvent extends Equatable {
  SpeakerEvent([List props = const []]) : super(props);
}

class LoadSpeakers extends SpeakerEvent {}

class InitSpeakers extends SpeakerEvent {}

class UpdateSpeaker extends SpeakerEvent {
  final Speaker updatedSpeaker;
  UpdateSpeaker(this.updatedSpeaker) : super([updatedSpeaker]);
}

class ModifySpeaker extends SpeakerEvent {
  final Speaker updatedSpeaker;
  ModifySpeaker(this.updatedSpeaker) : super([updatedSpeaker]);
}

class DeleteSpeaker extends SpeakerEvent {
  final Speaker speaker;
  DeleteSpeaker(this.speaker) : super([speaker]);
}
