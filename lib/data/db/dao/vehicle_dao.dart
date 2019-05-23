import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:sqflite/sqflite.dart';

class VehicleDao {
  Future<Database> _db;

  VehicleDao(AppDatabase appDatabase) {
    _db = appDatabase.database;
  }

  Future<int> insert(Vehicle vehicle) async {
    final db = await _db;
    return await db.insert('vehicle', vehicle.toJson());
  }

  Future insertMany(List<Vehicle> cars) async {
    final db = await _db;
    final batch = db.batch();
    cars.forEach((c) {
      batch.insert("vehicle", c.toJson());
    });

    return await batch.commit(noResult: true);
  }

  Future update(Vehicle vehicle) async {
    final db = await _db;
    final json = vehicle.toJson();
    json.remove("id");
    await db.update('vehicle', json, where: "id = ?", whereArgs: [vehicle.id]);
  }

  Future delete(String plate) async {
    final db = await _db;
    await db.delete('vehicle', where: "plate = ?", whereArgs: [plate]);
  }

  Future deleteAll() async {
    final db = await _db;
    await db.delete('vehicle');
  }

  Future<List<Vehicle>> all() async {
    final db = await _db;
    var cars = await db.query("vehicle", orderBy: 'plate');
    return compute(parseList, cars);
  }

  Future<Vehicle> selected() async {
    final db = await _db;
    var vehicle = await db.query("vehicle", where: "selected = ?", whereArgs: [1], limit: 1);
    return vehicle.isNotEmpty ? Vehicle.fromJson(vehicle.first) : null;
  }

  Future<Vehicle> next() async {
    final db = await _db;
    var vehicle = await db.query("vehicle", orderBy: "plate", limit: 1);
    return vehicle.isNotEmpty ? Vehicle.fromJson(vehicle.first) : null;
  }
}

List<Vehicle> parseList(List<Map<String, dynamic>> json) =>
    json.map((x) => Vehicle.fromJson(x)).toList();
