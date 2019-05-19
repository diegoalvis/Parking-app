import 'package:flutter/material.dart';
import 'package:oneparking_citizen/data/repository/info_repository.dart';


class DayHourColumn extends StatelessWidget {

  DayHourColumn({Key key, this.days, this.times}) : super(key: key);

  final String days;
  final List<ScheduleTime> times;

  @override
  Widget build(BuildContext context) {
    final dayHourColumn = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: 15.0,
          ),
          child: Text(
            this.days,
            style: TextStyle(
                fontSize: 12.0,
                color: Color.fromARGB(0xFF, 0x55, 0x96, 0xD6),
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15.0,
            bottom: 15.0
          ),
          child: Text("",
              //"${this.times.init} a ${this.times.end}",
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black54
              ),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        )
      ],
    );

    return dayHourColumn;
  }
}
