import 'package:equatable/equatable.dart';

class CounterModel extends Equatable {
  final int value;

  const CounterModel({this.value = 0});

  CounterModel copyWith({int? value}) {
    return CounterModel(value: value ?? this.value);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(value: json['value']);
  }

  @override
  List<Object?> get props => [value];
}
