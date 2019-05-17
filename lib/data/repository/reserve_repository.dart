import 'package:oneparking_citizen/data/api/model/reserve.dart';
import 'package:oneparking_citizen/data/api/reserve_api.dart';
import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/reserve_dao.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/config.dart';
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

  ReserveRepository(this._session, this._api, this._reserveDao, this._errors, this._vehicleDao, this._configDao);

  Future<int> getValue() async {
    final config = await _configDao.get();
    final reserve = this.reserve ?? await _reserveDao.get();
    if (reserve == null) {
      return 0;
    }

    final parkingTime = DateTime.now().difference(reserve.date).inMinutes;
    if (parkingTime < config.limitTime) {
      return 0;
    } else if (parkingTime < config.baseTime) {
      return config.basePrice;
    } else {
      final additionalTime = parkingTime - config.baseTime;
      return (config.basePrice + (additionalTime * config.fractionPrice / config.fractionTime)).round();
    }
  }

  Future<Reserve> getCurrentReserve() async {
    // TODO: fetch data from server
    //reserve = _reserveDao.get();
    reserve = Reserve(plate: "DIEGO", date: DateTime.now(), address: "Test direccion");
    return Future.value(Reserve(plate: "DIEGO", date: DateTime.now(), address: "Test direccion"));
  }

  Future start(String idZone, String name, String address, String code, bool disability) async {
    final selected = await _vehicleDao.selected();

    final rspn =
        await _api.reserve(ReserveReq(disability: disability, code: code, idZone: idZone, vehicle: selected.toBaseVehicle()));
    if (!rspn.success) _errors.validateError(rspn.error);
    final res = rspn.data;
    _session.setReserving(true);
    await _reserveDao.insert(Reserve(
        date: res.date, idReserve: res.idReserve, name: name, address: address, plate: selected.plate, type: selected.type));
  }

  Future stop() async {
    final reserve = await _reserveDao.get();
    final rspn = await _api.reserveStop(reserve.idReserve);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _reserveDao.remove();
    _session.setReserving(false);
  }

  Future forceStop() async {
    await _reserveDao.remove();
    _session.setReserving(false);
  }

  Future<Reserve> current() async => await _reserveDao.get();
}
