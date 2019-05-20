import 'package:flutter/material.dart';
import 'package:oneparking_citizen/data/repository/info_repository.dart';

class DayHourColumn extends StatelessWidget {
  DayHourColumn({Key key, this.days, this.times}) : super(key: key);

  final String days;
  final List<ScheduleTime> times;

  @override
  Widget build(BuildContext context) {
    final init = Duration(minutes: this.times[0].init);
    final end = Duration(minutes: this.times[0].end);
    final initialTime = TimeOfDay(hour: init.inHours, minute: init.inMinutes % 60).format(context);
    final endTime = TimeOfDay(hour: end.inHours, minute: end.inMinutes % 60).format(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 15.0,
          ),
          child: Text(
            this.days,
            style: TextStyle(fontSize: 12.0, color: Color.fromARGB(0xFF, 0x55, 0x96, 0xD6), fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0, bottom: 15.0),
          child: Text(
            "$initialTime a $endTime",
            style: TextStyle(fontSize: 13.0, color: Colors.black54),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        )
      ],
    );
  }
}
