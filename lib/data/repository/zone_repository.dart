import 'package:oneparking_citizen/data/api/zone_api.dart';
import 'package:oneparking_citizen/data/db/dao/schedule_dao.dart';
import 'package:oneparking_citizen/data/db/dao/zone_dao.dart';
import 'package:oneparking_citizen/data/models/event.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class ZoneRepository {
  ZoneApi _api;
  ScheduleDao _scheduleDao;
  ErrorCodes _errors;
  ZoneDao _zoneDao;
  UserSession _session;

  ZoneRepository(this._session, this._api, this._scheduleDao, this._zoneDao, this._errors);

  Future<ZoneDes> getState(String idZone, String type) async {

    final holy = await _session.holyDay;
    if(holy) return ZoneDes(des:StateZ.holyday);

    final now = DateTime.now();
    final mins = (now.hour * 60) + now.minute;
    final day = now.weekday - 1;

    final schedule = await _scheduleDao.get(type, day, min: mins);
    if (schedule == null) return ZoneDes(des: StateZ.timeout);

    final rspn = await _api.state(idZone);
    if (!rspn.success) _errors.validateError(rspn.error);

    final state = rspn.data;

    if (state.event != null && !state.event.available)
      return ZoneDes(des: StateZ.event, event: state.event.event);

    return ZoneDes(des: StateZ.active, state: state.state);
  }

  Future<List<Zone>> getZones() async => await _zoneDao.all();
}

enum StateZ { active, event, timeout, holyday }

class ZoneDes {
  StateZ des;
  Event event;
  ZoneState state;

  ZoneDes({this.des, this.event, this.state});
}
