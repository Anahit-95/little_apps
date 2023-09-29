import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';

import './timer_states.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial());

  Timer? _timer;

  startTimer([int? time]) {
    Wakelock.enable();
    if (time != null) {
      emit(TimerProgress(time));
    } else {
      emit(const TimerProgress(0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  onTick(Timer timer) {
    if (state is TimerProgress) {
      TimerProgress wip = state as TimerProgress;
      if (wip.elapsed! < 10) {
        emit(TimerProgress(wip.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const TimerInitial());
      }
    }
  }
}
