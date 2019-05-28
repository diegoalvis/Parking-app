import 'package:oneparking_citizen/data/api/model/reserve.dart';
import 'package:oneparking_citizen/data/api/reserve_api.dart';
import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/reserve_dao.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class ReserveRepository {
  UserSession _session;
  ReserveApi _api;
  ReserveDao _reserveDao;
  VehicleDao _vehicleDao;
  ConfigDao _configDao;
  ErrorCodes _errors;

  Reserve reserve;

  ReserveRepository(this._session, this._api, this._reserveDao, this._errors,
      this._vehicleDao, this._configDao);

  Future<int> getValue({final int timeInMinutes}) async {
    var config = await _configDao.get();
    final reserve = this.reserve ?? await _reserveDao.get();
    if (reserve == null) {
      return 0;
    }
    if (timeInMinutes <= config.limitTime) {
      return 0;
    } else if (timeInMinutes <= config.baseTime) {
      return config.basePrice;
    } else {
      final additionalTime = timeInMinutes - config.baseTime;
      final fractions = (additionalTime / config.fractionTime).ceil();

      return config.basePrice + (fractions * config.fractionPrice);
    }
  }

  Future start(String idZone, String name, String address, String code,
      bool disability) async {
    final selected = await _vehicleDao.selected();

    final rspn = await _api.reserve(ReserveReq(
        disability: disability,
        code: code,
        idZone: idZone,
        vehicle: selected.toBaseVehicle()));
    if (!rspn.success) _errors.validateError(rspn.error);
    final res = rspn.data;
    _session.setReserving(true);
    await _reserveDao.insert(Reserve(
        date: res.date,
        idReserve: res.idReserve,
        name: name,
        address: address,
        plate: selected.plate,
        type: selected.type));
  }

  Future<int> stop() async {
    final reserve = await _reserveDao.get();
    final rspn = await _api.reserveStop(reserve.idReserve);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _reserveDao.remove();
    _session.setReserving(false);
    return rspn.data.cost;
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

      info.retired = rspn.data.retired ?? false;
      info.stopped = rspn.data.stopped ?? false;
      if(info.stopped){
        info.value = rspn.data.totalCost;
        info.time = (rspn.data.time / 60).ceil();
      }

      if(info.retired){
        await _reserveDao.remove();
        _session.setReserving(false);
      }

    }
    return info;
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

  ReserveInfo({this.reserve, this.stopped, this.retired, this.time, this.value});
}