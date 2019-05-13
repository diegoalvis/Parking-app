import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/models/event.dart';
import 'package:sqflite/sqlite_api.dart';

class EventDao{

  Future<Database> _db;

  EventDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<int> insert(Event event) async{
    final db = await _db;
    return await db.insert('event', event.toJson());
  }

  Future insertZones(int event, List<String> ids) async{
    final db = await _db;
    final batch = db.batch();
    ids.forEach((z){
      final json = <String, dynamic>{
        'event':event,
        'idZone':z
      };
      batch.insert("eventzone", json);
    });

    return await batch.commit(noResult: true);
  }

  Future<Event> get(String zone) async{
    final db = await _db;

    final sqlDate = "AND (DATE('now') = DATE(fromDate) OR DATE('now') BETWEEN DATE(fromDate) AND DATE(toDate))";
    final result = await db.rawQuery("SELECT event.* from event, eventzone WHERE eventzone.idZone = '$zone' AND event.id = eventzone.event $sqlDate");
    return result.isNotEmpty ? Event.fromJson(result[0]) : null;
  }

  Future removeAll() async{
    final db = await _db;
    await db.delete('event');
  }

}

