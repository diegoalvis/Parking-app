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
      initialTime?.inMinutes,
      (initialTime?.inSeconds ?? 0) % 60,
      stop,
    ));
  }
}

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
  final Function onTimeIncremented;
  final stop;
  int initialMinutes;
  int initialSeconds;

  Dependencies(this.onTimeIncremented, this.initialMinutes, this.initialSeconds, this.stop) {
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
      final duration = Duration(minutes: dependencies.initialMinutes, seconds: dependencies.initialSeconds);
      milliseconds = dependencies.stopwatch.elapsedMilliseconds + duration.inMilliseconds;
      if ((milliseconds ~/ 1000) % 10 == 0) {
        dependencies?.onTimeIncremented(Duration(milliseconds: milliseconds).inMinutes);
      }
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
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
          child: Center(child: Hundreds(dependencies: dependencies)),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  final Dependencies dependencies;

  MinutesAndSeconds(this.dependencies);

  MinutesAndSecondsState createState() => MinutesAndSecondsState(dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  final Dependencies dependencies;
  int minutes = 0;
  int seconds = 0;

  MinutesAndSecondsState(this.dependencies);

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return Text('$minutesStr:$secondsStr.', style: TextStyle(color: Colors.black, fontSize: 80.0));
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});

  final Dependencies dependencies;

  HundredsState createState() => HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});

  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return Text(hundredsStr, style: TextStyle(fontSize: 50.0));
  }
}
