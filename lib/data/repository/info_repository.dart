import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/schedule_dao.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/models/schedules.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:rxdart/rxdart.dart';

class InfoRepository {

  ConfigDao _configDao;
  ScheduleDao _scheduleDao;

  InfoRepository(this._configDao, this._scheduleDao);

  Future<Info> get() async {
    final config = await _configDao.get();
    final residential = await _processSchedule(TYPE_RESIDENTIAL);
    final business = await _processSchedule(TYPE_BUSINESS);
    return Info(config, residential, business);
  }

  Future<List<ScheduleInfo>> _processSchedule(String type) {
    return Observable.fromFuture(_scheduleDao.all(type))
        .flatMap((x) => Observable.fromIterable(x))
        .map((x) {
          final label = _getLabel(x);
          return ScheduleSingle(
              label['index'], label['label'], ScheduleTime(x.initTime, x.endTime));
        }).toList().asObservable()
            .map((x) {
          x.sort((a, b) => a.index - b.index);
          return x;
        })
        .flatMap((x) => Observable.fromIterable(x))
        .groupBy((x) => x.label)
        .flatMap((gp) => gp.map((x) => x.times)
            .toList().asObservable()
            .map((x) {
              x.sort((a, b) => a.init - b.init);
              return x;
            })
            .map((x)=> ScheduleInfo(gp.key, x)))
        .toList();
  }

  Map<String, dynamic> _getLabel(Schedules schedule) {
    List<int> days = [];
    if (schedule.mo == 1) days.add(0);
    if (schedule.tu == 1) days.add(1);
    if (schedule.we == 1) days.add(2);
    if (schedule.th == 1) days.add(3);
    if (schedule.fr == 1) days.add(4);
    if (schedule.sa == 1) days.add(5);
    if (schedule.su == 1) days.add(6);

    String label = _dayByIndex(days[0]);
    if (days.length > 1) {
      label += ' a ' + _dayByIndex(days.last);
    }
    return {'index': days[0], 'label': label};
  }

  String _dayByIndex(int index) {
    switch (index) {
      case 0:
        return 'Lunes';
      case 1:
        return 'Martes';
      case 2:
        return 'Miercoles';
      case 3:
        return 'Jueves';
      case 4:
        return 'Viernes';
      case 5:
        return 'Sabado';
      default:
        return 'Domingo';
    }
  }

}

class Info {

  Config config;
  List<ScheduleInfo> residentialSchedules;
  List<ScheduleInfo> businessSchedules;

  Info(this.config, this.residentialSchedules, this.businessSchedules);

}

class ScheduleInfo {
  String label;
  List<ScheduleTime> times;

  ScheduleInfo(this.label, this.times);
}

class ScheduleTime {
  int init;
  int end;

  ScheduleTime(this.init, this.end);
}

class ScheduleSingle {
  int index;
  String label;
  ScheduleTime times;

  ScheduleSingle(this.index, this.label, this.times);
}