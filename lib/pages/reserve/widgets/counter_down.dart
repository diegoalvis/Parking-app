import 'dart:async';

import 'package:flutter/material.dart';

class CounterDown extends StatelessWidget {
  final Duration initialTime;
  final Function(int) onTimeIncremented;
  final bool stop;

  const CounterDown({Key key, this.initialTime, this.onTimeIncremented, this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerText(Dependencies(
      onTimeIncremented,
      initialTime?.inHours,
      (initialTime?.inMinutes ?? 0) % 60,
      (initialTime?.inSeconds ?? 0) % 60,
      stop,
    ));
  }
}

class ElapsedTime {
  final int seconds;
  final int minutes;
  final int hours;

  ElapsedTime({
    this.seconds,
    this.minutes,
    this.hours,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = Stopwatch();
  final int timerMillisecondsRefreshRate = 1000;
  final Function onTimeIncremented;
  final stop;
  int initialHours;
  int initialMinutes;
  int initialSeconds;

  Dependencies(this.onTimeIncremented, this.initialHours, this.initialMinutes, this.initialSeconds, this.stop) {
    if (stop) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }
}

class TimerText extends StatefulWidget {
  final Dependencies dependencies;

  TimerText(this.dependencies);

  TimerTextState createState() => TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  final Dependencies dependencies;

  TimerTextState({this.dependencies});

  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      final duration = Duration(hours: dependencies.initialHours,  minutes: dependencies.initialMinutes, seconds: dependencies.initialSeconds);
      milliseconds = dependencies.stopwatch.elapsedMilliseconds + duration.inMilliseconds;
      if ((milliseconds ~/ 1000) % 10 == 0) {
        dependencies?.onTimeIncremented(Duration(milliseconds: milliseconds).inMinutes);
      }
      final int seconds = (milliseconds / 1000).truncate();
      final int minutes = (seconds / 60).truncate();
      final int hours = (minutes / 60).truncate();
      final ElapsedTime elapsedTime = ElapsedTime(
        seconds: seconds,
        minutes: minutes,
        hours: hours,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
          child: MinutesAndSeconds(dependencies),
        ),
        RepaintBoundary(
          child: Center(child: Seconds(dependencies: dependencies)),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  final Dependencies dependencies;

  MinutesAndSeconds(this.dependencies);

  HoursAndMinutesState createState() => HoursAndMinutesState(dependencies);
}

class HoursAndMinutesState extends State<MinutesAndSeconds> {
  final Dependencies dependencies;
  int minutes = 0;
  int hours = 0;

  HoursAndMinutesState(this.dependencies);

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.hours != hours) {
      setState(() {
        minutes = elapsed.minutes;
        hours = elapsed.hours;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    return Text('$hoursStr:$minutesStr', style: TextStyle(color: Colors.black, fontSize: 80.0));
  }
}

class Seconds extends StatefulWidget {
  Seconds({this.dependencies});

  final Dependencies dependencies;

  SecondsState createState() => SecondsState(dependencies: dependencies);
}

class SecondsState extends State<Seconds> {
  SecondsState({this.dependencies});

  final Dependencies dependencies;

  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.seconds != seconds) {
      setState(() {
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return Text(secondsStr, style: TextStyle(fontSize: 50.0));
  }
}
