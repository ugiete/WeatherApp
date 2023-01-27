import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/weather/payload/current_weather.dart';

const String kHost = 'api.openweathermap.org';

Future<CurrentWeatherModel?> getCurrentWeather(LocationModel location) async {
  Uri uri = Uri.https(
    kHost,
    '/data/2.5/weather',
    {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': '03ff0e0da72e418ffce159c4018ac33d',
      'units': 'metric'
    }
  );

  http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    return CurrentWeatherModel.fromJSON(body);
  }

  return null;
}