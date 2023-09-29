import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/models/counter_model.dart';

void main() {
  group('CounterBloc', () {
    const mockCounter = CounterModel();

    setUp(() {});

    CounterBloc buildBloc() {
      return CounterBloc();
    }

    group('contructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const CounterState()),
        );
      });

      group('CounterStarted', () {
        blocTest(
          'emits [success] when is loaded successfully for the first time',
          build: () => CounterBloc(),
          act: (bloc) => bloc.add(CounterStarted()),
          expect: () => [
            const CounterState(
              counter: mockCounter,
              status: CounterStatus.success,
            )
          ],
        );

        blocTest(
          'emits [] when counter is loaded again',
          build: () => CounterBloc(),
          seed: () => const CounterState(
            counter: mockCounter,
            status: CounterStatus.success,
          ),
          act: (bloc) => bloc.add(CounterStarted()),
          expect: () => [],
        );
      });

      group('CounterIncrementPressed', () {
        blocTest(
          'emits [CounterState] when the user taps the increment button',
          build: () => CounterBloc(),
          act: (bloc) => bloc.add(CounterIncrementPressed()),
          expect: () => [
            const CounterState(
              counter: CounterModel(value: 1),
              status: CounterStatus.success,
            ),
          ],
        );

        blocTest(
          'emits [CounterState] when the user taps the increment button twice, emits two new states incrases the value by two',
          build: () => CounterBloc(),
          act: (bloc) => bloc
            ..add(CounterIncrementPressed())
            ..add(CounterIncrementPressed()),
          expect: () => [
            const CounterState(
              counter: CounterModel(value: 1),
              status: CounterStatus.success,
            ),
            const CounterState(
              counter: CounterModel(value: 2),
              status: CounterStatus.success,
            ),
          ],
        );
        blocTest(
          'emits [CounterState] when the user taps the increment button twice, incrases the value by two',
          build: () => CounterBloc(),
          act: (bloc) => bloc
            ..add(CounterIncrementPressed())
            ..add(CounterIncrementPressed()),
          skip: 1,
          expect: () => [
            const CounterState(
              counter: CounterModel(value: 2),
              status: CounterStatus.success,
            ),
          ],
        );
      });

      group('CounterDecrementPressed', () {
        blocTest(
          'emits [CounterState] when the user taps the decrement button',
          build: () => CounterBloc(),
          act: (bloc) => bloc.add(CounterDecrementPressed()),
          expect: () => const [
            CounterState(
              counter: CounterModel(value: -1),
              status: CounterStatus.success,
            ),
          ],
        );

        blocTest(
          'emits [CounterState] when the user taps the decrement button twice, emits two new states decrases the value by two',
          build: () => CounterBloc(),
          act: (bloc) => bloc
            ..add(CounterDecrementPressed())
            ..add(CounterDecrementPressed()),
          expect: () => const [
            CounterState(
              counter: CounterModel(value: -1),
              status: CounterStatus.success,
            ),
            CounterState(
              counter: CounterModel(value: -2),
              status: CounterStatus.success,
            ),
          ],
        );

        blocTest(
          'emits [CounterState] when the user taps the increment button twice, decrases the value by two',
          build: () => CounterBloc(),
          act: (bloc) => bloc
            ..add(CounterDecrementPressed())
            ..add(CounterDecrementPressed()),
          skip: 1,
          expect: () => const [
            CounterState(
              counter: CounterModel(value: -2),
              status: CounterStatus.success,
            ),
          ],
        );
      });
    });
  });
}
