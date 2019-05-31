import 'package:oneparking_citizen/data/api/setup_api.dart';
import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/schedule_dao.dart';
import 'package:oneparking_citizen/data/db/dao/zone_dao.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/models/schedules.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class SetupRepository {
  UserSession _session;
  ZoneDao _zone;
  ConfigDao _config;
  ScheduleDao _schedule;
  SetupApi _api;
  ErrorCodes _errors;

  SetupRepository(this._session, this._api, this._zone, this._config, this._schedule, this._errors);

  Future<bool> isCurrentVersion() async {
    final version = await _session.version;
    final rspn = await _api.loadSetup(true, version: version);
    if (!rspn.success) _errors.validateError(rspn.error);
    if(rspn.data.holy == true){
      _session.setHolyDay(true);
    }else{
      _session.setHolyDay(false);
    }
    return version == rspn.data.version;
  }

  Future setupCurrentVersion() async {
    final version = await _session.version;
    final rspn = await _api.loadSetup(false, version: version);
    if (!rspn.success) _errors.validateError(rspn.error);

    final zones = rspn.data.zones;
    final ids = zones.map((z) => z.id).toList();
    final zns = zones.map((z) => z.toZone()).toList();
    await _zone.removeByIdZone(ids);
    await _zone.insertMany(zns);

    final config = rspn.data.config;
    await _config.remove();
    await _config.insert(config.toConfig());

    await _schedule.removeAll();
    final business = _prepareSchedule(config.businessSchedule, TYPE_BUSINESS);
    await _schedule.insertMany(business);

    final residential = _prepareSchedule(config.businessSchedule, TYPE_RESIDENTIAL);
    await _schedule.insertMany(residential);

    final currentVersion = rspn.data.version;
    _session.setVersion(currentVersion);
  }

  List<Schedules> _prepareSchedule(List<TimeRange> times, String type) {
    List<Schedules> schedules = List();
    times.forEach((t) {
      schedules.addAll(t.toSchedules(type));
    });
    return schedules;
  }
}
