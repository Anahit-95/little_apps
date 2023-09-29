import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notification_app/timer_app/bloc/timer_states.dart';
import 'bloc/timer_cubit.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('The BloC Timer'),
          ),
          body: BlocBuilder<TimerCubit, TimerState>(
            builder: ((context, state) {
              if (state is TimerInitial) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<TimerCubit>(context).startTimer(0),
                    child: const Text("Start"),
                  ),
                );
              }
              if (state is TimerProgress) {
                return Center(
                  child: Text(
                    '${state.elapsed!}',
                    style: const TextStyle(fontSize: 36),
                  ),
                );
              }
              return Container();
            }),
          )),
    );
  }
}
