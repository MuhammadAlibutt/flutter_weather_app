import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Controller/Controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Model/weather_hourly_data.dart';

class WeatherHourlyDataWidget extends StatelessWidget {
  final WeatherHourlyData weatherHourlyData;
  WeatherHourlyDataWidget({super.key, required this.weatherHourlyData});

  RxInt currentIndex = GlobleCoontroller().GetIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherHourlyData.hourly.length > 12
            ? 12
            : weatherHourlyData.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                currentIndex.value = index;
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0.5, 0),
                        spreadRadius: 1,
                        blurRadius: 30,
                        color: const Color.fromARGB(255, 239, 237, 237),
                      ),
                    ],
                    gradient: currentIndex.value == index
                        ? const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 5, 140, 251),
                              Color.fromARGB(255, 5, 142, 247)
                            ],
                          )
                        : null),
                child: HourlyWeatherDetails(
                  temp: weatherHourlyData.hourly[index].temp!,
                  time: weatherHourlyData.hourly[index].dt!,
                  icon: weatherHourlyData.hourly[index].weather![0].icon!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class HourlyWeatherDetails extends StatelessWidget {
  int temp;
  int time;
  String icon;

  String getTime(final timeStamp) {
    DateTime miliSecondTime =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String convertedTime = DateFormat('jm').format(miliSecondTime);

    return convertedTime;
  }

  HourlyWeatherDetails(
      {super.key, required this.temp, required this.time, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(getTime(time)),
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        ),
        Container(
          height: 45,
          width: 45,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset('assets/weather/$icon.png'),
        ),
        Container(
          child: Text('$temp°'),
        )
      ],
    );
  }
}
