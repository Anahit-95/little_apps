import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/calculator/calculator_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/data/repositories/operation_repository.dart';

void main() {
  late CalculatorBloc calculatorBloc;

  setUp(() {
    calculatorBloc = CalculatorBloc(operationRepository: OperationRepository());
  });
  group('Calculator Bloc Testing', () {
    test('Initial Test', () {
      expect(calculatorBloc.state, const CalculatorInitial('Result'));
    });

    test('props are correct', () {
      expect(calculatorBloc.state.props, <String>['Result']);
    });

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorResultSuccessful(10.0)] when AddButtonTapped(5, 5) is added.',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const AddButtonTapped(5, 5)),
      expect: () => const <CalculatorState>[
        CalculatorResultSuccessful(10.0),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorResultSuccessful(0.0)] when SubtractButtonTapped(5, 5) is added.',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const SubtractButtonTapped(5, 5)),
      expect: () => const <CalculatorState>[
        CalculatorResultSuccessful(0.0),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorResultSuccessful(25.0)] when MultiplyButtonTapped(5, 5) is added.',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const MultiplyButtonTapped(5, 5)),
      expect: () => const <CalculatorState>[
        CalculatorResultSuccessful(25.0),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorResultSuccessful(1.0)] when DivideButtonTapped(5, 5) is added.',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const DivideButtonTapped(5, 5)),
      expect: () => const <CalculatorState>[
        CalculatorResultSuccessful(1.0),
      ],
    );
  });
}
