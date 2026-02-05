class Event {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  final double price;
  final int availableSpots;
  final String image;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.price,
    required this.availableSpots,
    required this.image,
  });

  Event copyWith({
    String? id,
    String? title,
    String? category,
    DateTime? date,
    double? price,
    String? image,
    int? availableSpots,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      price: price ?? this.price,
      image: image ?? this.image,
      availableSpots: availableSpots ?? this.availableSpots,
    );
  }
}
