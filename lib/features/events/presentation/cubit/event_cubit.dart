import 'package:ci_projecct/core/utils/network/api_error_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/event.dart';
import '../../domain/usecases/get_events_usecase.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final GetEventsUseCase getEventsUseCase;

  EventCubit({required this.getEventsUseCase}) : super(EventInitial());

  void loadEvents() async {
    emit(EventLoading());
    final Either<ApiErrorModel, List<Event>> result = await getEventsUseCase();
    result.fold(
      (l) => emit(EventError(l.message ?? "")),
      (r) => emit(EventLoaded(allEvents: r)),
    );
  }

  void updateSearchQuery(String query) {
    if (state is EventLoaded) {
      emit((state as EventLoaded).copyWith(searchQuery: query));
    }
  }

  void updateSelectedCategory(String category) {
    if (state is EventLoaded) {
      emit((state as EventLoaded).copyWith(selectedCategory: category));
    }
  }

  void bookEvent(String id) {
    if (state is EventLoaded) {
      final loaded = state as EventLoaded;
      final updatedEvents =
          loaded.allEvents.map((e) {
            if (e.id == id && e.availableSpots > 0) {
              return e.copyWith(availableSpots: e.availableSpots - 1);
            }
            return e;
          }).toList();
      emit(loaded.copyWith(allEvents: updatedEvents));
    }
  }

  void updateEventSpots(String eventId) {
    if (state is EventLoaded) {
      final currentState = state as EventLoaded;
      final updatedEvents =
          currentState.allEvents.map((event) {
            if (event.id == eventId && event.availableSpots > 0) {
              return event.copyWith(availableSpots: event.availableSpots - 1);
            }
            return event;
          }).toList();

      emit(currentState.copyWith(allEvents: updatedEvents));
    }
  }
}
