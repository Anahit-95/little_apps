import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/calculator/calculator_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/data/repositories/operation_repository.dart';
import 'package:flutter_testing_ex/counter_bloc_app/screens/calculator_page.dart';

void main() {
  testWidgets('Calculator page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) =>
            CalculatorBloc(operationRepository: OperationRepository()),
        child: CalculatorPage(),
      ),
    ));

    expect(find.text('Result'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('*'), findsOneWidget);
    expect(find.text('/'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.enterText(find.byKey(const ValueKey('firstOperand')), '10');
    await tester.enterText(find.byKey(const ValueKey('secondOperand')), '10');

    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('20.0'), findsOneWidget);

    await tester.tap(find.text('-'));
    await tester.pump();
    expect(find.text('0.0'), findsOneWidget);

    await tester.tap(find.text('*'));
    await tester.pump();
    expect(find.text('100.0'), findsOneWidget);

    await tester.tap(find.text('/'));
    await tester.pump();
    expect(find.text('1.0'), findsOneWidget);
  });
}
