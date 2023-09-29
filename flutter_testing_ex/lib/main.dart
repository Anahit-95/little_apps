import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/calculator/calculator_bloc.dart';
import 'package:flutter_testing_ex/counter_bloc_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_testing_ex/news_app/news_change_notifier.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'counter.dart';
import 'counter_bloc_app/blocs/weather/weather_bloc.dart';
import 'counter_bloc_app/data/repositories/operation_repository.dart';
import 'counter_bloc_app/data/repositories/weather_repository.dart';
import 'counter_bloc_app/screens/calculator_page.dart';
import 'counter_bloc_app/screens/counter_screen.dart';
import 'counter_bloc_app/screens/weather_search_page.dart';
import 'news_app/news_page.dart';
import 'news_app/news_service.dart';
import 'user_app/user_model.dart';
import 'user_app/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChangeNotifierProvider(
      //   create: (_) => NewsChangeNotifier(NewsService()),
      //   child: const NewsPage(),
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: BlocProvider(
      //   create: (context) => CounterBloc()..add(CounterStarted()),
      //   child: const CounterScreen(),
      // ),
      // home: BlocProvider(
      //   create: (context) => CalculatorBloc(
      //     operationRepository: OperationRepository(),
      //   ),
      //   child: CalculatorPage(),
      // ),
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// class _MyHomePageState extends State<MyHomePage> {
//   final Counter counter = Counter();

//   void _incrementCounter() {
//     setState(() {
//       counter.incrementCounter();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${counter.count}',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

class _MyHomePageState extends State<MyHomePage> {
  Future<User> getUsers = UserRepository(Client()).getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Text(
              '${snapshot.data}',
            ),
          );
        },
      ),
    );
  }
}
