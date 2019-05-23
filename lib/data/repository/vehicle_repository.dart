import 'package:oneparking_citizen/data/api/vehicle_api.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class VehicleRepository{

  VehicleDao _dao;
  VehicleApi _api;
  ErrorCodes _errors;

  VehicleRepository(this._api,this._dao);

  Future<String> add(VehicleBase vehicle) async{
    final rspn = await _api.add(vehicle);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _dao.insert(vehicle.toLocal());
    return rspn.data;
  }

  Future<List<Vehicle>> all() async{
    return await _dao.all();
  }

  Future<List<Vehicle>> reload() async{
    final rspn = await _api.all();
    if (!rspn.success) _errors.validateError(rspn.error);
    await _dao.deleteAll();
    final vehicles = rspn.data.map((x)=> x.toLocal()).toList();
    vehicles[0].selected = 1;
    await _dao.insertMany(vehicles);
    return await _dao.all();
  }

  Future<String> remove(Vehicle vehicle) async{
    final rspn = await _api.remove(vehicle.plate);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _dao.delete(vehicle.plate);
    if(vehicle.selected == 1){
      final next = await _dao.next();
      next.selected = 1;
      await _dao.update(next);
    }
    return rspn.data;
  }

  Future<int> select(Vehicle vehicle) async{
    Vehicle selected = await _dao.selected();
    selected.selected = 0;
    await _dao.update(selected);
    vehicle.selected = 1;
    await _dao.update(vehicle);
    return vehicle.id;
  }

  Future<Vehicle> selected() async => await _dao.selected();

}