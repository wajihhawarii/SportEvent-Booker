import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_booking_usecase.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final AddBookingUseCase addBooking;
  final GetBookingsUseCase getBookings;

  BookingCubit({required this.addBooking, required this.getBookings})
    : super(BookingInitial());

  Future<void> loadBookings() async {
    emit(BookingLoading());

    final result = await getBookings();

    emit(BookingLoaded(result));
  }
}
