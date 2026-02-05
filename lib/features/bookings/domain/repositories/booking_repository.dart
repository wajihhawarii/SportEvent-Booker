import '../entities/booking.dart';

abstract class BookingRepository {
  Future<void> addBooking(Booking booking);

  Future<List<Booking>> getBookings();
}
