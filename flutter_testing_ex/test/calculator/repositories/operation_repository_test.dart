import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/data/repositories/operation_repository.dart';

void main() {
  group('Calculator Operation test -', () {
    final operation = OperationRepository();

    test('Testing SUM', () {
      final sum = operation.sum(operand1: 1, operand2: 1);
      expect(sum, 2);
    });

    test('Testing Difference 1-1', () {
      final sum = operation.difference(operand1: 1, operand2: 1);
      expect(sum, 0);
    });

    test('Testing product 1*1', () {
      final sum = operation.product(operand1: 1, operand2: 1);
      expect(sum, 1);
    });

    test('Testing division 1/1', () {
      final sum = operation.division(operand1: 1, operand2: 1);
      expect(sum, 1);
    });
  });
}
