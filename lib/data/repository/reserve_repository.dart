import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneparking_citizen/data/api/bill_api.dart';
import 'package:oneparking_citizen/data/api/model/reserve.dart';
import 'package:oneparking_citizen/data/api/reserve_api.dart';
import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/reserve_dao.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class ReserveRepository {
  UserSession _session;
  ReserveApi _api;
  BillApi _apiBill;
  ReserveDao _reserveDao;
  VehicleDao _vehicleDao;
  ConfigDao _configDao;
  ErrorCodes _errors;


  Reserve reserve;

  Config _config;
  Vehicle _selected;

  ReserveRepository(this._session, this._api, this._reserveDao, this._errors,
      this._vehicleDao, this._configDao);

  Future<int> getValue({final int timeInMinutes}) async {
    if(_config == null){
      _config = await _configDao.get();
    }

    if(_selected == null){
      _selected = await _vehicleDao.selected();
    }

    final basePrice = _selected.type == TYPE_CAR ?_config.basePrice : _config.mcBasePrice;
    final fractionPrice = _selected.type == TYPE_CAR ?_config.fractionPrice : _config.mcFractionPrice;

    final reserve = this.reserve ?? await _reserveDao.get();
    if (reserve == null) {
      return 0;
    }
    if (timeInMinutes <= _config.limitTime) {
      return 0;
    } else if (timeInMinutes <= _config.baseTime) {
      return basePrice;
    } else {
      final additionalTime = timeInMinutes - _config.baseTime;
      final fractions = (additionalTime / _config.fractionTime).ceil();

      return basePrice + (fractions * fractionPrice);
    }
  }

  Future start(String idZone, String name, String address, String code,
      bool disability, LatLng pos) async {
    final selected = await _vehicleDao.selected();

    final rspn = await _api.reserve(ReserveReq(
        disability: disability,
        code: code,
        idZone: idZone,
        vehicle: selected.toBaseVehicle()));
    if (!rspn.success) _errors.validateError(rspn.error);
    final res = rspn.data;
    _session.setReserving(true);
    _session.setLastLoc(pos);
    await _reserveDao.insert(Reserve(
        date: res.date,
        idReserve: res.idReserve,
        name: name,
        address: address,
        plate: selected.plate,
        type: selected.type));
  }

  Future<ReserveInfo> stop() async {
    final reserve = await _reserveDao.get();
    final rspn = await _api.reserveStop(reserve.idReserve);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _reserveDao.remove();
    _session.setReserving(false);

    // final debt = await _debtValue(reserve.plate);
    return ReserveInfo(value:rspn.data.cost);
  }

  Future forceStop() async {
    await _reserveDao.remove();
    _session.setReserving(false);
  }

  Future<ReserveInfo> current() async {
    final reserve = await _reserveDao.get();
    ReserveInfo info = ReserveInfo(reserve: reserve);

    if(reserve != null){
      final rspn = await _api.byId(reserve.idReserve);
      if (!rspn.success) _errors.validateError(rspn.error);
      int debt = 0;
      info.retired = rspn.data.retired ?? false;
      info.stopped = rspn.data.stopped ?? false;
      if(info.stopped){
        info.value = rspn.data.totalCost;
        info.time = (rspn.data.time / 60).ceil();
        // debt = await _debtValue(info.reserve.plate);
        // info.debt = debt;
      }

      if(info.retired){
        await _reserveDao.remove();
        _session.setReserving(false);
      }

    }
    return info;
  }

  Future<int> _debtValue(String plate) async{
    final rspn = await _apiBill.allDebtByPlate(plate);
    if (!rspn.success) _errors.validateError(rspn.error);
    int value = 0;
    rspn.data.forEach((e)=> value += e.value);
    return value;
  }
}

class StopReserveException implements Exception {
  String cause;

  StopReserveException({this.cause});
}

class ReserveInfo{
  Reserve reserve;
  bool stopped;
  bool retired;
  int time;
  int value;
  int debt;

  ReserveInfo({this.reserve, this.stopped, this.retired, this.time, this.value, this.debt});
}