import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/models/counter_model.dart';

void main() {
  group('CounterState', () {
    const mockCounter = CounterModel();

    group('CounterState, initial', () {
      const mockStatus = CounterStatus.initial;

      CounterState createSubject() {
        return const CounterState(
          counter: mockCounter,
          status: mockStatus,
        );
      }

      test('supports value equality', () {
        expect(
          createSubject(),
          equals(createSubject()),
        );
      });

      test('props are correct', () {
        expect(
          createSubject().props,
          equals(<Object?>[mockCounter, mockStatus]),
        );
      });

      test('returns object with updated status', () {
        expect(
          createSubject().copyWith(
            status: CounterStatus.success,
          ),
          const CounterState(
            counter: mockCounter,
            status: CounterStatus.success,
          ),
        );
      });

      test('returns a valid [CounterState] with CounterState.fromJson', () {
        final Map<String, dynamic> json = {
          'counter': {'value': 0},
          'status': 'initial',
        };
        final state = CounterState.fromJson(json);
        expect(state, createSubject());
      });

      test('returns a Map with CounterState.toJson', () {
        Map<String, dynamic> json = createSubject().toJson();

        expect(
          json,
          {
            'counter': {'value': 0},
            'status': 'initial',
          },
        );
      });
    });

    group('CounterState, success', () {
      const mockStatus = CounterStatus.success;

      CounterState createSubject() {
        return const CounterState(
          counter: mockCounter,
          status: mockStatus,
        );
      }

      test('supports value equality', () {
        expect(
          createSubject(),
          equals(createSubject()),
        );
      });
    });
  });
}
