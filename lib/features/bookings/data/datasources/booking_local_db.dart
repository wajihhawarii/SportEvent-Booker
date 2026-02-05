import 'package:ci_projecct/core/data_base/app_database.dart';
import 'package:ci_projecct/features/bookings/data/models/booking_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookingLocalDataSource {
  Future<void> addBooking(BookingModel booking) async {
    try {
      final db = await AppDatabase.database;

      print("Inserting booking: ${booking.toMap()}");

      await db.insert(
        'bookings',
        booking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print("Booking saved successfully in SQLite");
    } catch (e) {
      print("Error saving booking: $e");
    }
  }

  Future<List<BookingModel>> getBookings() async {
    final db = await AppDatabase.database;

    final result = await db.query('bookings');

    return result.map((e) => BookingModel.fromMap(e)).toList();
  }

  Future<void> deleteOldDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sport_booker.db');

    print('Database path: $path');

    await deleteDatabase(path);
    print('Database deleted!');
  }
}
