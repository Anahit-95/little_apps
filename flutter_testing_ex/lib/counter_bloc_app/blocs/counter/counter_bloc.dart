import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/counter_model.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncrementPressed>(_onIncrementPressed);
    on<CounterDecrementPressed>(_onDecrementPressed);
  }

  void _onStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) {
    if (state.status == CounterStatus.success) return;
    CounterModel counter = const CounterModel();
    emit(
      CounterState(
        counter: counter,
        status: CounterStatus.success,
      ),
    );
  }

  void _onIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) {
    int value = state.counter.value + 1;
    CounterModel counter = state.counter.copyWith(value: value);
    emit(
      state.copyWith(
        counter: counter,
        status: CounterStatus.success,
      ),
    );
  }

  void _onDecrementPressed(
    CounterDecrementPressed event,
    Emitter<CounterState> emit,
  ) {
    int value = state.counter.value - 1;
    CounterModel counter = state.counter.copyWith(value: value);
    emit(
      state.copyWith(
        counter: counter,
        status: CounterStatus.success,
      ),
    );
  }
}
