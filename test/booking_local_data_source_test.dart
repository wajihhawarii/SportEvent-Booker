import 'package:flutter_test/flutter_test.dart';
import 'package:ci_projecct/features/bookings/data/models/booking_model.dart';
import 'package:ci_projecct/features/bookings/data/datasources/booking_local_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  late BookingLocalDataSource dataSource;

  setUp(() async {
    dataSource = BookingLocalDataSource();

    await dataSource.deleteOldDatabase();
  });

  group('BookingLocalDataSource Tests', () {
    test('should add a booking and retrieve it', () async {
      // Arrange
      final booking = BookingModel(
        id: '1',
        eventId: "3",
        title: 'Champions League Final',
        image: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2',
        bookedAt: DateTime.parse('2026-02-04T12:03:04.057478'),
      );

      // Act
      await dataSource.addBooking(booking);
      final bookings = await dataSource.getBookings();

      // Assert
      expect(bookings.length, 1);
      expect(bookings.first.id, '1');
      expect(bookings.first.eventId, "3");
      expect(bookings.first.title, 'Champions League Final');
    });
  });
}
