part of 'counter_bloc.dart';

enum CounterStatus { initial, loading, success, error }

class CounterState extends Equatable {
  final CounterModel counter;
  final CounterStatus status;

  const CounterState({
    this.counter = const CounterModel(),
    this.status = CounterStatus.initial,
  });

  CounterState copyWith({
    CounterModel? counter,
    CounterStatus? status,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'counter': counter.toJson(),
      'status': status.name,
    };
  }

  factory CounterState.fromJson(Map<String, dynamic> json) {
    return CounterState(
      counter: CounterModel.fromJson(json['counter']),
      status: CounterStatus.values.firstWhere(
        (element) => element.name.toString() == json['status'],
      ),
    );
  }

  @override
  List<Object> get props => [counter, status];
}
