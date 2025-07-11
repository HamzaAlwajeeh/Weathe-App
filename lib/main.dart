import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit_state.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubitCubit(),
      child: BlocBuilder<GetWeatherCubitCubit, WeatherState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: false,
              primarySwatch: getThemeColor(
                BlocProvider.of<GetWeatherCubitCubit>(context)
                    .weatherModel
                    ?.condition,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}

//steps of bloc:
//[1] Create states
//[2] Craete cubit
//[3] Create functions in cubit
//[4] provide cubit using BlocProvider
//[5] Integrate cubit
//[6] Trigger cubit

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  condition = condition.toLowerCase();
  switch (condition) {
    case 'sunny':
    case 'clear':
      return Colors.orange;

    case 'partly cloudy':
    case 'cloudy':
    case 'overcast':
      return Colors.grey;

    case 'mist':
    case 'fog':
    case 'freezing fog':
      return Colors.blueGrey;

    case 'patchy rain possible':
    case 'patchy light rain':
    case 'light rain':
    case 'moderate rain at times':
    case 'moderate rain':
    case 'heavy rain at times':
    case 'heavy rain':
    case 'light freezing rain':
    case 'moderate or heavy freezing rain':
    case 'light rain shower':
    case 'moderate or heavy rain shower':
    case 'torrential rain shower':
    case 'patchy light rain with thunder':
    case 'moderate or heavy rain with thunder':
      return Colors.blue;

    case 'patchy snow possible':
    case 'patchy sleet possible':
    case 'patchy light snow':
    case 'light snow':
    case 'patchy moderate snow':
    case 'moderate snow':
    case 'patchy heavy snow':
    case 'heavy snow':
    case 'blowing snow':
    case 'blizzard':
    case 'light snow showers':
    case 'moderate or heavy snow showers':
    case 'patchy light snow with thunder':
    case 'moderate or heavy snow with thunder':
      return Colors.indigo;

    case 'patchy light drizzle':
    case 'light drizzle':
    case 'freezing drizzle':
    case 'heavy freezing drizzle':
    case 'patchy freezing drizzle possible':
      return Colors.lightBlue;

    case 'light sleet':
    case 'moderate or heavy sleet':
    case 'light sleet showers':
    case 'moderate or heavy sleet showers':
      return Colors.deepPurple;

    case 'ice pellets':
    case 'light showers of ice pellets':
    case 'moderate or heavy showers of ice pellets':
      return Colors.cyan;

    case 'thundery outbreaks possible':
      return Colors.deepOrange;

    default:
      return Colors.teal;
  }
}
