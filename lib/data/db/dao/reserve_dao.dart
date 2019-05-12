import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:sqflite/sqlite_api.dart';

class ReserveDao{

  Future<Database> _db;

  ReserveDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<Reserve> get() async{
    final db = await _db;
    final result = await db.query('reserve');
    return result.isNotEmpty ? Reserve.fromJson(result[0]) : null;
  }

  Future remove() async{
    final db = await _db;
    await db.delete('reserve');
  }

  Future<int> insert(Reserve reserve) async{
    final db = await _db;
    return await db.insert('reserve', reserve.toJson());
  }

}