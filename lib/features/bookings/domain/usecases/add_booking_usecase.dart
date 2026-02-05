import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class AddBookingUseCase {
  final BookingRepository repository;

  AddBookingUseCase(this.repository);

  Future<void> call(Booking booking) {
    return repository.addBooking(booking);
  }
}
