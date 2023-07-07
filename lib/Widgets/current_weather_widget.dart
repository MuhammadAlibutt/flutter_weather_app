import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Model/weather_current_data.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final weatherCurrentData currentData;
  const CurrentWeatherWidget({Key? key, required this.currentData})
      : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //show current temp and icon
        currentempDetails(),

        SizedBox(
          height: 15,
        ),
        //show weather Detials
        currentweatDetails(),
      ],
    );
  }

//show current temp and icon
  Widget currentempDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
            "assets/weather/${widget.currentData.current.weather![0].icon}.png"),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${widget.currentData.current.temp!.toInt()}°",
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))
        ]))
      ],
    );
  }

  //show weather Detials
  Widget currentweatDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 237, 237),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/icons/clouds.png'),
            ),
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 237, 237),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/icons/humidity.png'),
            ),
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 237, 237),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/icons/windspeed.png'),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                width: 80,
                height: 40,
                child: Text(
                  "Cloud: ${widget.currentData.current.clouds}%",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: SizedBox(
                width: 80,
                height: 40,
                child: Text(
                  "Humidity: ${widget.currentData.current.humidity}%",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                width: 80,
                height: 40,
                child: Text(
                  "Wind: ${widget.currentData.current.windSpeed}km/h",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
