import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/weather/weather_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/data/repositories/weather_repository.dart';
import 'package:flutter_testing_ex/counter_bloc_app/models/weather.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends MockBloc implements WeatherRepository {}

void main() {
  late WeatherBloc weatherBloc;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherBloc = WeatherBloc(mockWeatherRepository);
  });

  Weather weather = const Weather(cityName: 'London', temperatureCelsius: 7);
  Future<void> getWeatherFromService() async {
    when(() => mockWeatherRepository.fetchWeather('London')).thenAnswer(
      (_) async => weather,
    );
  }

  group('GetWeather', () {
    test('Initial test', () {
      expect(weatherBloc.state, const WeatherInitial());
    });

    blocTest(
      'emits [WeatherLoading, WeatherLoaded] when succesfull',
      build: () {
        getWeatherFromService();
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const GetWeather('London')),
      expect: () => [
        const WeatherLoading(),
        WeatherLoaded(weather),
      ],
    );

    blocTest(
      'Emits [WeatherLoading, WeatherError] when unsuccessful',
      build: () {
        when(() => mockWeatherRepository.fetchWeather('London'))
            .thenThrow(NetworkError());
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const GetWeather('London')),
      expect: () => const [
        WeatherLoading(),
        WeatherError('Couldn\'t fetch weather. Is device online?'),
      ],
    );
  });
}
