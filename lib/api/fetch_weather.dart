import 'dart:convert';

import 'package:flutter_weather_app/Model/weather_current_data.dart';
import 'package:flutter_weather_app/Model/weather_daily_data.dart';
import 'package:flutter_weather_app/Model/weather_data.dart';
import 'package:flutter_weather_app/Model/weather_hourly_data.dart';
import 'package:flutter_weather_app/api/api_key.dart';
import 'package:http/http.dart' as http;

class FetchWeatherData {
  WeatherData? weatherData;

  //coonverting the data froom response to json
  Future<WeatherData> processedData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));

    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      weatherCurrentData.fromJson(jsonString),
      WeatherHourlyData.fromJson(jsonString),
      WeatherDailyData.fromJson(jsonString),
    );

    return weatherData!;
  }

  String apiUrl(lat, lon) {
    String url;
    url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&exclude=minutely&units=metric";
    // "https://api.openweathermap.org/data/3.0/onecall?lat=32.10931167394988&lon=74.87164848179086&appid=$apiKey&exclude=minutely&units=metric";

    return url;
  }
}
