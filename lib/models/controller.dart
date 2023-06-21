import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather360_latest_verion/services/api_services.dart';

class Controller extends GetxController {
  var isloading = true.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  dynamic currentWeatherData;
  dynamic hourlyWeatherData;

  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    hourlyWeatherData = getHourlyWeather(latitude.value, longitude.value);
    super.onInit();
  }

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isloading.value = true;
    });
  }
}
