import 'package:ci_projecct/features/bookings/data/datasources/booking_local_db.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource local;

  BookingRepositoryImpl(this.local);

  @override
  Future<void> addBooking(Booking booking) {
    final model = BookingModel(
      id: booking.id,
      eventId: booking.eventId,
      title: booking.title,
      image: booking.image,
      bookedAt: booking.bookedAt,
    );

    return local.addBooking(model);
  }

  @override
  Future<List<Booking>> getBookings() async {
    return await local.getBookings();
  }
}
