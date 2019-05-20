import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/schedules.dart';
import 'package:sqflite/sqlite_api.dart';

class ScheduleDao {
  Future<Database> _db;

  ScheduleDao(AppDatabase appDatabase) {
    _db = appDatabase.database;
  }

  Future insertMany(List<Schedules> schedules) async {
    final db = await _db;
    final batch = db.batch();
    schedules.forEach((z){
      batch.insert("schedule", z.toJson());
    });

    return await batch.commit(noResult: true);
  }

  Future removeAll() async {
    final db = await _db;
    await db.delete('schedule');
  }

  Future<Schedules> get(String type, int day, {int min}) async{
    final db = await _db;
    String dayQuery = '';
    switch(day){
      case 0: dayQuery = 'mo = 1'; break;
      case 1: dayQuery = 'tu = 1'; break;
      case 2: dayQuery = 'we = 1'; break;
      case 3: dayQuery = 'th = 1'; break;
      case 4: dayQuery = 'fr = 1'; break;
      case 5: dayQuery = 'sa = 1'; break;
      case 6: dayQuery = 'su = 1'; break;
    }
    String minQuery = '';
    if(min != null){
      minQuery = ' AND endTime > $min AND initTime <= $min';
    }

    final result = await db.query('schedule', where: dayQuery + " AND type = '$type' $minQuery");
    return result.isNotEmpty ? Schedules.fromJson(result[0]) : null;
  }

  Future<List<Schedules>> all(String type) async{
    final db = await _db;
    final schedules =  await db.query('schedule', where:'type = ?', whereArgs: [type]);
    return compute(parseList, schedules);
  }
}

List<Schedules> parseList(List<Map<String, dynamic>> json) => json.map((x)=> Schedules.fromJson(x)).toList();