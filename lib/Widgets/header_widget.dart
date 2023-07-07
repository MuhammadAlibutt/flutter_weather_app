import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Controller/Controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';

  String date = DateFormat("yMMMMd").format(DateTime.now());

//calling thee controller
  final GlobleCoontroller globleCoontroller =
      Get.put(GlobleCoontroller(), permanent: true);

  @override
  void initState() {
    getAddress(globleCoontroller.getLatitude().value,
        globleCoontroller.getLongitude().value);
    super.initState();
  }

// getting City Name
  getAddress(lat, lon) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(fontSize: 30, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(fontSize: 19, height: 1, color: Colors.blue[200]),
          ),
        )
      ],
    );
  }
}
