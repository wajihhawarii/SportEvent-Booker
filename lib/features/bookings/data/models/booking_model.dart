import '../../domain/entities/booking.dart';
import '../../../events/domain/entities/event.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.eventId,
    required super.title,
    required super.image,
    required super.bookedAt,
  });

  factory BookingModel.fromEvent(Event event) {
    return BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      eventId: event.id,
      title: event.title,
      image: event.image,
      bookedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'title': title,
      'image': image,
      'bookedAt': bookedAt.toIso8601String(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      bookedAt: DateTime.parse(map['bookedAt'] as String),
    );
  }
}
