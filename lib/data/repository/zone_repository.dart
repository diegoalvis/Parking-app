import 'package:oneparking_citizen/data/api/zone_api.dart';
import 'package:oneparking_citizen/data/db/dao/event_dao.dart';
import 'package:oneparking_citizen/data/db/dao/schedule_dao.dart';
import 'package:oneparking_citizen/data/db/dao/zone_dao.dart';
import 'package:oneparking_citizen/data/models/event.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class ZoneRepository {
  ZoneApi _api;
  ScheduleDao _scheduleDao;
  EventDao _eventDao;
  ErrorCodes _errors;
  ZoneDao _zoneDao;

  ZoneRepository(this._api, this._eventDao, this._scheduleDao, this._zoneDao, this._errors);

  Future<ZoneDes> getState(String idZone, String type) async {
    final event = await _eventDao.get(idZone);
    if (event != null) return ZoneDes(des: StateZ.event, event: event);

    final now = DateTime.now();
    final mins = (now.hour * 60) + now.minute;
    final day = now.weekday - 1;

    final schedule = await  _scheduleDao.get(type, day, min: mins);
    if(schedule == null) return ZoneDes(des:StateZ.timeout);

    final rspn = await _api.state(idZone);
    if (!rspn.success) _errors.validateError(rspn.error);

    return ZoneDes(des: StateZ.active, state: rspn.data);
  }

  Future<List<Zone>> getZones() async => await _zoneDao.all();
}

enum StateZ { active, event, timeout }

class ZoneDes {
  StateZ des;
  Event event;
  ZoneState state;

  ZoneDes({this.des, this.event, this.state});
}
