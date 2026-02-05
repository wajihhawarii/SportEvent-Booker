import 'package:ci_projecct/features/events/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.title,
    required super.category,
    required super.date,
    required super.price,
    required super.availableSpots,
    required super.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      price: (json['price'] as num).toDouble(),
      availableSpots: json['available_spots'],
      image: json['image_url'],
    );
  }
}
