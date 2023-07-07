import 'package:flutter_weather_app/Model/weather_current_data.dart';
import 'package:flutter_weather_app/Model/weather_daily_data.dart';
import 'package:flutter_weather_app/Model/weather_hourly_data.dart';

class WeatherData {
  final weatherCurrentData? current;
  final WeatherHourlyData? hourly;
  final WeatherDailyData? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  weatherCurrentData getCurrentWeather() => current!;
  WeatherHourlyData getHourlyWeather() => hourly!;
  WeatherDailyData getDailyWeather() => daily!;
}
