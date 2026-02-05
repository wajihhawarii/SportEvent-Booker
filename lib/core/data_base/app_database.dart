import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sport_booker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings (
        id TEXT PRIMARY KEY,
        eventId TEXT,
        title TEXT,
        image TEXT,
        bookedAt TEXT
      )
    ''');
    print('================ Database Created Successfully ================');
    List<Map<String, dynamic>> columns = await db.rawQuery(
      'PRAGMA table_info(bookings)',
    );
    print('Table Structure:');
    for (var column in columns) {
      print('Column: ${column['name']} | Type: ${column['type']}');
    }
  }
}
