import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter.dart';

void main() {
  late Counter counter;

  setUp(() {
    counter = Counter();
  });

  group('Counter Class - ', () {
    test(
        'given counter class when it is instantiated then value of count should be 0',
        () {
      final val = counter.count;

      expect(val, 0);
    });

    test(
      'given counter class when it is incremented then the value should be 1',
      () {
        counter.incrementCounter();
        final val = counter.count;

        expect(val, 1);
      },
    );

    test(
      'given counter class when it is decremented then the value should be -1',
      () {
        counter.decrementCounter();
        final val = counter.count;

        expect(val, -1);
      },
    );

    test(
      'given counter class when it is reset then the value of count should be 0',
      () {
        counter.incrementCounter();
        counter.incrementCounter();
        counter.resetCounter();
        final val = counter.count;

        expect(val, 0);
      },
    );
  });
}
