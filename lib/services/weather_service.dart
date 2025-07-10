import 'package:dio/dio.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  WeatherService({required this.dio});

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$kBaseUrl/forecast.json?key=$kApiKey&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['error']['message'] ??
          'oops there is an error , try again later';

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('oops there is an error , try again later');
    }
  }
}
