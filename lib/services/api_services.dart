import 'package:http/http.dart' as http;
import 'package:weather360_latest_verion/models/current_weather_model.dart';
import 'package:weather360_latest_verion/models/hourly_weather_model.dart';


getCurrentWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid="your API Key"&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = currentWeatherDataFromJson(res.body.toString());

    return data;
  }
}

getHourlyWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=e8251067c8601d1e828fac588fdb7daf&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = hourlyWeatherDataFromJson(res.body.toString());

    return data;
  }
}
