import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetBookingsUseCase {
  final BookingRepository repository;

  GetBookingsUseCase(this.repository);

  Future<List<Booking>> call() {
    return repository.getBookings();
  }
}
