import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class GetWeatherCubitCubit extends Cubit<WeatherState> {
  GetWeatherCubitCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;
  getWeather({required String cityName}) async {
    try {
      weatherModel = await WeatherService(dio: Dio())
          .getCurrentWeather(cityName: cityName);
      emit(WeatherLoadedState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailureState(errorMessage: e.toString()));
    }
  }
}
