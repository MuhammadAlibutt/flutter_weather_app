import 'package:flutter_weather_app/Model/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../api/fetch_weather.dart';

class GlobleCoontroller extends GetxController {
  //declare Varaialble
  final RxBool _islooading = true.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

//get current weather data
  final weatherData = WeatherData().obs;
  WeatherData getData() {
    return weatherData.value;
  }

//instantance oof variable
  RxBool checkIsloading() => _islooading;
  RxDouble getLongitude() => _longitude;
  RxDouble getLatitude() => _latitude;

  //oninit function too gett location
  @override
  void onInit() {
    if (_islooading.isTrue) {
      getLocation();
    } else {
      GetIndex();
    }
    super.onInit();
  }

//Function getLocation()

  getLocation() async {
    bool isServicesEnabled;

    isServicesEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission isLocationPermission;

    //if services are not enabled
    if (!isServicesEnabled) {
      return Future.error('Location service is not enabled');
    }

    //permission status
    isLocationPermission = await Geolocator.checkPermission();

//if denied Forever
    if (isLocationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission Denied Forever');
    }
//if permission Denied
    else if (isLocationPermission == LocationPermission.denied) {
      isLocationPermission = await Geolocator.requestPermission();
    }

// get Current Position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) => {
              //update latitude and longitude values
              _latitude.value = value.latitude,
              _longitude.value = value.longitude,

              FetchWeatherData()
                  .processedData(value.latitude, value.longitude)
                  .then((value) => {
                        weatherData.value = value,
                        _islooading.value = false,
                      }),
            });
  }

  RxInt GetIndex() {
    return _currentIndex;
  }
}
