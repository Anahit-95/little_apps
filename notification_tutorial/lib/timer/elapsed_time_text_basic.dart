import 'package:flutter/material.dart';

class ElapsedTimeTextBasic extends StatelessWidget {
  final Duration elapsed;
  const ElapsedTimeTextBasic({
    Key? key,
    required this.elapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seconds = elapsed.inSeconds % 60;
    final minutes = elapsed.inMinutes % 60;
    final hours = elapsed.inHours;
    final secondStr = seconds.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    final hourStr = hours.toString().padLeft(2, '0');

    return Text(
      '$hourStr:$minutesStr:$secondStr',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
      ),
    );
  }
}
