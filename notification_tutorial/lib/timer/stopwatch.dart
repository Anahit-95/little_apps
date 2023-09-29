import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import './elapsed_time_text_basic.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  late DateTime _initialTime;
  Duration _elapsed = Duration.zero;
  Timer? _timer;

  late final Ticker _ticker;

  // int seconds = 0, minutes = 0, hours = 0;
  // String digitSeconds = '00', digitMinutes = '00', digitHours = '00';

  // @override
  // void initState() {
  //   super.initState();
  //   _initialTime = DateTime.now();
  //   _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
  //     final now = DateTime.now();
  //     setState(() {
  //       _elapsed = now.difference(_initialTime);
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _ticker = createTicker((elapsed) {
  //     setState(() {
  //       _elapsed = elapsed;
  //     });
  //   });
  //   _ticker.start();
  // }

  @override
  void dispose() {
    _timer?.cancel();
    // _ticker.dispose();
    super.dispose();
  }

  void startTicker() {
    _initialTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      setState(() {
        _elapsed = now.difference(_initialTime);
      });
    });

    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   int localSeconds = seconds + 1;
    //   int localMinutes = minutes;
    //   int localHours = hours;

    //   if (localSeconds > 59) {
    //     if (localMinutes > 59) {
    //       localHours++;
    //       localMinutes = 0;
    //     } else {
    //       localMinutes++;
    //       localSeconds = 0;
    //     }
    //   }
    //   setState(() {
    //     seconds = localSeconds;
    //     minutes = localMinutes;
    //     hours = localHours;
    //     digitSeconds = (seconds >= 10) ? '$seconds' : '0$seconds';
    //     digitMinutes = (minutes >= 10) ? '$minutes' : '0$minutes';
    //     digitHours = (hours >= 10) ? '$hours' : '0$hours';
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   '$digitHours:$digitMinutes:$digitSeconds',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 40,
        //   ),
        // ),
        ElapsedTimeTextBasic(
          elapsed: _elapsed,
        ),
        ElevatedButton(
          onPressed: startTicker,
          child: const Text('Start'),
        ),
        ElevatedButton(
          onPressed: () {
            // _ticker.stop(canceled: false);
            // _ticker.muted = true;
            _timer?.cancel();
          },
          child: const Text('Stop'),
        ),
      ],
    );
  }
}
