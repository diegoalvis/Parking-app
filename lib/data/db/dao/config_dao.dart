import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:sqflite/sqlite_api.dart';

class ConfigDao {

  Future<Database> _db;

  ConfigDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<Config> get() async{
    final db = await _db;
    final result = await db.query('config');
    return result.isNotEmpty ? Config.fromJson(result[0]) : null;
  }

  Future remove() async{
    final db = await _db;
    await db.delete('config');
  }

  Future<int> insert(Config config) async{
    final db = await _db;
    return await db.insert('config', config.toJson());
  }

}