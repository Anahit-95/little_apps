// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather/weather_bloc.dart';
import '../models/weather.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  const WeatherDetailPage({
    Key? key,
    required this.masterWeather,
  }) : super(key: key);

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
        .add(GetDetailedWeather(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Detail"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the Celsius temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        Text(
          // Display the Fahrenheit temperature with 1 decimal place
          "${weather.temperatureFarenheit.toStringAsFixed(1)} °F",
          style: const TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}
