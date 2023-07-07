import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Controller/Controller.dart';
import 'package:flutter_weather_app/Widgets/hourly_weather_widget.dart';
import 'package:get/get.dart';

import '../Widgets/current_weather_widget.dart';
import '../Widgets/daily_weather_widget.dart';
import '../Widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call contrller
  final GlobleCoontroller globleCoontroller =
      Get.put(GlobleCoontroller(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globleCoontroller.checkIsloading().isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  //show current location
                  const HeaderWidget(),

                  // show current weather
                  CurrentWeatherWidget(
                    currentData:
                        globleCoontroller.getData().getCurrentWeather(),
                  ),

                  //show hourly weather
                  WeatherHourlyDataWidget(
                    weatherHourlyData:
                        globleCoontroller.getData().getHourlyWeather(),
                  ),

                  //show weather of next days
                  DailyWeatherFoorcast(
                    dailyWeather: globleCoontroller.getData().getDailyWeather(),
                  )
                ],
              )),
      ),
    );
  }
}
