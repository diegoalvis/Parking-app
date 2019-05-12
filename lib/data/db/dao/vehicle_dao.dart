import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:sqflite/sqflite.dart';

class VehicleDao{

  Future<Database> _db;

  VehicleDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<int> insert(VehicleLocal vehicle) async{
    final db = await _db;
    return await db.insert('vehicle', vehicle.toJson());
  }
  
  Future insertMany(List<VehicleLocal> cars) async{
    final db = await _db;
    final batch = db.batch();
    cars.forEach((c){
      batch.insert("vehicle", c.toJson());
    });

    return await batch.commit(noResult: true);
  }

  Future update(VehicleLocal vehicle) async{
    final db = await _db;
    await db.update('vehicle', vehicle.toJson());
  }

  Future delete(int id) async{
    final db = await _db;
    await db.delete('vehicle', where: "id = ?", whereArgs: [id]);
  }

  Future deleteAll() async{
    final db = await _db;
    await db.delete('vehicle');
  }

  Future<List<VehicleLocal>> all() async{
    final db = await _db;
    var cars = await db.query("vehicle", orderBy: 'plate');
    return compute((v)=> v.map<VehicleLocal>((json) => VehicleLocal.fromJson(json)).toList(), cars);
  }

  Future<VehicleLocal> selected() async{
    final db = await _db;
    var vehicle = await db.query("vehicle", where: "selected = ?", whereArgs: [1], limit: 1);
    return vehicle.isNotEmpty ? VehicleLocal.fromJson(vehicle.first) : null;
  }

  Future<VehicleLocal> next() async{
    final db = await _db;
    var vehicle = await db.query("vehicle", orderBy: "plate", limit: 1);
    return vehicle.isNotEmpty ? VehicleLocal.fromJson(vehicle.first) : null;
  }

}