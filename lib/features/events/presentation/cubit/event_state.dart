import '../../domain/entities/event.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> allEvents;
  final String searchQuery;
  final String selectedCategory;

  EventLoaded({
    required this.allEvents,
    this.searchQuery = '',
    this.selectedCategory = 'All',
  });

  List<Event> get filteredEvents {
    var temp = allEvents;

    if (selectedCategory != 'All') {
      temp = temp.where((e) => e.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      temp =
          temp
              .where(
                (e) =>
                    e.title.toLowerCase().contains(searchQuery.toLowerCase()),
              )
              .toList();
    }

    return temp;
  }

  EventLoaded copyWith({
    List<Event>? allEvents,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return EventLoaded(
      allEvents: allEvents ?? this.allEvents,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class EventError extends EventState {
  final String message;
  EventError(this.message);
}
