import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:it_forum_omsk/models/model_event.dart';
import 'package:it_forum_omsk/repositories/database_logic.dart';
import 'package:it_forum_omsk/blocs/event_event.dart';
import 'package:it_forum_omsk/blocs/event_state.dart';


class EventBloc extends Bloc<EventEvent, EventState> {
  DBLogicEvent _dbLogic = DBLogicEvent();

  // Display a loading indicator right from the start of the app
  @override
  EventState get initialState => EventsLoading();

  // This is where we place the logic.
  @override
  Stream<EventState> mapEventToState(
      EventEvent event,
      ) async* {

    if (event is LoadEvents) {
      yield EventsLoading();
      yield* _reloadEventsById(event.idDay);

    } else if (event is LoadSpeakerEvents) {
      yield EventsLoading();
      yield* _reloadSpeakerEvents(event.listId);

    } else if (event is LoadFavoriteEvents) {
      yield EventsLoading();
      yield* _reloadFavoriteEvents();

    } else if (event is InitEvents) {
      if (await _dbLogic.isEmptyEvents()) {
        for (final i in defaultEvent) {
          await _dbLogic.insert(i);
        }
      }

    } else if (event is ModifyEvent) {
      await _dbLogic.modifySelectedEvent(event.updatedEvent);
      yield* _reloadEventsById(event.updatedEvent.idDay);

    } else if (event is DeleteEvent) {
      await _dbLogic.delete(event.event);
      yield* _reloadEvents();
    }
  }

  Stream<EventState> _reloadEvents() async* {
    final events = await _dbLogic.getAllEvents();
    yield EventsLoaded(events);
  }

  Stream<EventState> _reloadEventsById(int idDay) async* {
    final events = await _dbLogic.getEvents(idDay);
    yield EventsLoaded(events);
  }

  Stream<EventState> _reloadSpeakerEvents(List<int> listId) async* {
    final events = await _dbLogic.getSpeakerEvents(listId);
    yield EventsLoaded(events);
  }


  Stream<EventState> _reloadFavoriteEvents() async* {
    final events = await _dbLogic.getFavoriteEvents();
    yield EventsLoaded(events);
  }
}

List<Event> defaultEvent = [
  Event(idDay: 1, nameEvent: 'Открытие ИТ-форума', chosen: false, timeSpending: '9.00 - 9.55', location: 'Большой зал'),
  Event(idDay: 1, nameEvent: 'Цифровой город', chosen: false, timeSpending: '10.05 - 11.00', location: 'Большой зал'),
  Event(idDay: 1, nameEvent: 'ИТ-технологии в реалиях современной российской экономики', chosen: false, timeSpending: '11.05 - 12.00', location: 'Синий зал'),
  Event(idDay: 1, nameEvent: 'Цифровое производство', chosen: false, timeSpending: '12.05 - 13.00', location: 'Зеленый зал'),
  Event(idDay: 1, nameEvent: 'Цифровой город', chosen: false, timeSpending: '13.05 - 14.00', location: 'Большой зал'),
  Event(idDay: 1, nameEvent: 'ИТ в образовании', chosen: false, timeSpending: '14.05 - 15.00', location: 'Малый зал'),
  Event(idDay: 1, nameEvent: 'Иновации в ИТ', chosen: false, timeSpending: '15.05 - 16.00', location: 'Укромный зал'),

  Event(idDay: 2, nameEvent: 'ИТ новости', chosen: false, timeSpending: '9.00 - 9.55', location: 'Малый зал'),
  Event(idDay: 2, nameEvent: 'Город будующего', chosen: false, timeSpending: '10.05 - 11.00', location: 'Большой зал'),
  Event(idDay: 2, nameEvent: 'Перспективы в ИТ', chosen: false, timeSpending: '11.05 - 12.00', location: 'Укромный зал'),
  Event(idDay: 2, nameEvent: 'Омск и его специалисты', chosen: false, timeSpending: '12.05 - 13.00', location: 'Зеленый зал'),
  Event(idDay: 2, nameEvent: 'Веб-Омск', chosen: false, timeSpending: '13.05 - 14.00', location: 'Синий зал'),
  Event(idDay: 2, nameEvent: 'Фундамент ИТ', chosen: false, timeSpending: '14.05 - 15.00', location: 'Красный зал'),
  Event(idDay: 2, nameEvent: 'ИТ-Кластер', chosen: false, timeSpending: '15.05 - 16.00', location: 'Малый зал'),

  Event(idDay: 3, nameEvent: 'ИТ будущее', chosen: false, timeSpending: '9.00 - 9.55', location: 'Укромный зал'),
  Event(idDay: 3, nameEvent: 'Город будующего', chosen: false, timeSpending: '10.05 - 11.00', location: 'Большой зал'),
  Event(idDay: 3, nameEvent: 'Перспективы в ИТ', chosen: false, timeSpending: '11.05 - 12.00', location: 'Синий зал'),
  Event(idDay: 3, nameEvent: 'Омск и его специалисты', chosen: false, timeSpending: '12.05 - 13.00', location: 'Зеленый зал'),
  Event(idDay: 3, nameEvent: 'Веб-Омск', chosen: false, timeSpending: '13.05 - 14.00', location: 'Синий зал'),
  Event(idDay: 3, nameEvent: 'Фундамент ИТ', chosen: false, timeSpending: '14.05 - 15.00', location: 'Красный зал'),
  Event(idDay: 3, nameEvent: 'ИТ-Кластер', chosen: false, timeSpending: '15.05 - 16.00', location: 'Малый зал'),
];