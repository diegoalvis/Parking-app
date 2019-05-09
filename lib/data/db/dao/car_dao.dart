import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/car.dart';
import 'package:sqflite/sqflite.dart';

class CarDao{

  Future<Database> _db;

  CarDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<int> insert(CarLocal car) async{
    final db = await _db;
    return await db.insert('car', car.toJson());
  }
  
  Future insertMany(List<CarLocal> cars) async{
    final db = await _db;
    final batch = db.batch();
    cars.forEach((c){
      batch.insert("car", c.toJson());
    });

    return await batch.commit(noResult: true);
  }

  Future update(CarLocal car) async{
    final db = await _db;
    await db.update('car', car.toJson());
  }

  Future delete(int id) async{
    final db = await _db;
    await db.delete('car', where: "id = ?", whereArgs: [id]);
  }

  Future deleteAll() async{
    final db = await _db;
    await db.delete('car');
  }

  Future<List<CarLocal>> all() async{
    final db = await _db;
    var cars = await db.query("car", orderBy: 'placa');
    return compute((v)=> v.map<CarLocal>((json) => CarLocal.fromJson(json)).toList(), cars);
  }

  Future<CarLocal> selected() async{
    final db = await _db;
    var car = await db.query("car", where: "selected = ?", whereArgs: [1], limit: 1);
    return car.isNotEmpty ? CarLocal.fromJson(car.first) : null;
  }

  Future<CarLocal> next() async{
    final db = await _db;
    var car = await db.query("car", orderBy: "placa", limit: 1);
    return car.isNotEmpty ? CarLocal.fromJson(car.first) : null;
  }

}