import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/weather/weather_bloc.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  test('Example mocked BLoC test', () async {
    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [const WeatherInitial(), const WeatherLoading()],
      ),
      initialState: const WeatherInitial(),
    );

    await expectLater(
      mockWeatherBloc.stream,
      emitsInOrder([const WeatherInitial(), const WeatherLoading()]),
    );
  });
}
