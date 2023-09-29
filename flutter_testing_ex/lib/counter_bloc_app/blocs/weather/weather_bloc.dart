import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/weather_repository.dart';
import '../../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc(this.repository) : super(const WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      emit(const WeatherLoading());
      if (event is GetWeather) {
        try {
          final weather = await repository.fetchWeather(event.cityName);
          emit(WeatherLoaded(weather));
        } on NetworkError {
          emit(
            const WeatherError('Couldn\'t fetch weather. Is device online?'),
          );
        }
      } else if (event is GetDetailedWeather) {
        try {
          final weather = await repository.fetchDetailedWeather(event.cityName);
          emit(WeatherLoaded(weather));
        } on NetworkError {
          emit(
            const WeatherError('Couldn\'t fetch weather. Is device online?'),
          );
        }
      }
    });
  }
}
