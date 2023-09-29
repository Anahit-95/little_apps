import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/counter/counter_bloc.dart';

void main() {
  group('CounterEvent', () {
    group('CounterStarted', () {
      test('supports value equality', () {
        expect(
          CounterStarted(),
          CounterStarted(),
        );
      });

      test('props are correct', () {
        expect(
          CounterStarted().props,
          equals(<Object?>[]),
        );
      });
    });

    group('CounterIncrementPressed', () {
      test('supports value equality', () {
        expect(
          CounterIncrementPressed(),
          CounterIncrementPressed(),
        );
      });
    });

    group('CounterDecrementPressed', () {
      test('supports value equality', () {
        expect(
          CounterDecrementPressed(),
          CounterDecrementPressed(),
        );
      });
    });
  });
}
