import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:it_forum_omsk/database/model.dart';
import 'package:it_forum_omsk/database/database_logic.dart';
import 'package:it_forum_omsk/bloc/speaker_event.dart';
import 'package:it_forum_omsk/bloc/speaker_state.dart';


class SpeakerBloc extends Bloc<SpeakerEvent, SpeakerState> {
  DBLogicSpeaker _dbLogic = DBLogicSpeaker();

  // Display a loading indicator right from the start of the app
  @override
  SpeakerState get initialState => SpeakersLoading();

  // This is where we place the logic.
  @override
  Stream<SpeakerState> mapEventToState(
      SpeakerEvent speaker,
      ) async* {

    if (speaker is LoadSpeakers) {
      yield SpeakersLoading();
      yield* _reloadSpeakers();

    } else if (speaker is InitSpeakers) {
      if (await _dbLogic.isEmptySpeakers()) {
        for(final i in defaultSpeaker) {
          await _dbLogic.insert(i);
        }
      }
      yield* _reloadSpeakers();

    } else if (speaker is DeleteSpeaker) {
      await _dbLogic.delete(speaker.speaker);
      yield* _reloadSpeakers();
    }
  }

  Stream<SpeakerState> _reloadSpeakers() async* {
    final speakers = await _dbLogic.getAllSpeakers();
    yield SpeakersLoaded(speakers);
  }
}

List<List<int>> idEvent = [[1, 2], [3, 4], [6, 7]];

List<Speaker> defaultSpeaker = [
  Speaker(idEvent: idEvent[0], lastName: 'Тимофеечев', firstName: 'Александр', middleName: 'Михайлович', note: 'Президент НП «ИТ-Кластер Сибири», г. Омск',),
  Speaker(idEvent: idEvent[1], lastName: 'Клименко', firstName: 'Герман', middleName: 'Сергеевич', note: 'Председатель Фонда развития цифровой экономики, сопредседатель Совета ТПП РФ по ИТ и ЦЭ',),
  Speaker(idEvent: idEvent[2], lastName: 'Ложников', firstName: 'Павел', middleName: 'Сергеевич', note: 'К.т.н., доцент, заведующий кафедрой КЗИ ОмГТУ, г. Омск',),
];
