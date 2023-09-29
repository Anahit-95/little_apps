// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double temperatureFarenheit;

  const Weather({
    required this.cityName,
    required this.temperatureCelsius,
    this.temperatureFarenheit = 0,
  });

  @override
  List<Object> get props => [
        cityName,
        temperatureCelsius,
        temperatureFarenheit,
      ];
}
