import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'oneparking.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS car(
    id INTEGER PRIMARY KEY, 
    plate VARCHAR(10), 
    brand VARCHAR(25),
    type VARCHAR(25), 
    selected BOOLEAN DEFAULT 0
    )
    ''');
  }
}

