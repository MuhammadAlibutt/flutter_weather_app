import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Model/weather_daily_data.dart';
import 'package:intl/intl.dart';

class DailyWeatherFoorcast extends StatelessWidget {
  final WeatherDailyData dailyWeather;
  const DailyWeatherFoorcast({super.key, required this.dailyWeather});

// coonvert the value to days
  String getDay(day) {
    DateTime milisecoonds = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final convertedDay = DateFormat('EEE').format(milisecoonds);

    return convertedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 237, 237),
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 20),
          child: const Text('Whole Week Weather ForCast'),
        ),
        dailyWeatherList(),
      ]),
    );
  }

  Widget dailyWeatherList() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        itemCount:
            dailyWeather.daily.length > 7 ? 7 : dailyWeather.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 40,
                      child: Text(getDay(dailyWeather.daily[index].dt)),
                    ),
                    SizedBox(
                      width: 40,
                      height: 30,
                      child: Image.asset(
                          'assets/weather/${dailyWeather.daily[index].weather![0].icon}.png'),
                    ),
                    SizedBox(
                      width: 45,
                      height: 30,
                      child: Text(
                          "${dailyWeather.daily[index].temp!.max}/${dailyWeather.daily[index].temp!.min}°"),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey,
              )
            ],
          );
        },
      ),
    );
  }
}
