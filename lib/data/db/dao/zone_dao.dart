import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:sqflite/sqlite_api.dart';

class ZoneDao{

  Future<Database> _db;

  ZoneDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future insertMany(List<Zone> zones) async{
    final db = await _db;
    final batch = db.batch();
    zones.forEach((z){
      batch.insert("zone", z.toJson());
    });

    return await batch.commit(noResult: true);
  }

  Future<Zone> byId(int id) async{
    final db = await _db;
    final result = await db.query('zone', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Zone.fromJson(result[0]) : null;
  }

  Future<Zone> byIdZone(String zone) async{
    final db = await _db;
    final result = await db.query('zone', where: 'idZone = ?', whereArgs: [zone]);
    return result.isNotEmpty ? Zone.fromJson(result[0]) : null;
  }

  Future<List<Zone>> all() async{
    final db = await _db;
    var zones = await db.query("zone");
    return compute(parseList, zones);
  }

  Future removeByIdZone(List<String> ids) async{
    final db = await _db;
    return await db.delete('zone', where: "idZone IN ('${ids.join("','")}')" );
  }


}

List<Zone> parseList(List<Map<String, dynamic >> json) => json.map((x)=>Zone.fromJson(x)).toList();