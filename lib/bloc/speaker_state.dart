import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:it_forum_omsk/database/model.dart';


@immutable
abstract class SpeakerState extends Equatable {
  SpeakerState([List props = const []]) : super(props);
}

class SpeakersLoading extends SpeakerState {}

class SpeakersLoaded extends SpeakerState {
  final List<Speaker> speakers;

  SpeakersLoaded(this.speakers) : super([speakers]);
}