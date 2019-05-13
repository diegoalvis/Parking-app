import 'package:oneparking_citizen/data/api/model/reserve.dart';
import 'package:oneparking_citizen/data/api/reserve_api.dart';
import 'package:oneparking_citizen/data/db/dao/reserve_dao.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class ReserveRepository {

  UserSession _session;
  ReserveApi _api;
  ReserveDao _dao;
  VehicleDao _vehicleDao;
  ErrorCodes _errors;

  ReserveRepository(this._session, this._api, this._dao, this._errors, this._vehicleDao);

  Future start(String idZone, String name, String address, String code, bool disability) async {
    final selected = await _vehicleDao.selected();

    final rspn = await _api.reserve(ReserveReq(disability: disability, code: code, idZone: idZone, vehicle: selected.toBaseVehicle()));
    if (!rspn.success) _errors.validateError(rspn.error);
    final res = rspn.data;
    _session.setReserving(true);
    await _dao.insert(Reserve(date: res.date,
        idReserve: res.idReserve,
        name: name,
        address: address,
        plate: selected.plate,
        type: selected.type));
  }

  Future stop() async {
    final reserve = await _dao.get();
    final rspn = await _api.reserveStop(reserve.idReserve);
    if (!rspn.success) _errors.validateError(rspn.error);
    await _dao.remove();
    _session.setReserving(false);
  }

}