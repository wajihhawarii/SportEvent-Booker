class Booking {
  final String id;
  final String eventId;
  final String title;
  final String image;
  final DateTime bookedAt;

  const Booking({
    required this.id,
    required this.eventId,
    required this.title,
    required this.image,
    required this.bookedAt,
  });
}
