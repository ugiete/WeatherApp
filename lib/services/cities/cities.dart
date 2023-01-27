import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/services/cities/payload/find_cities.dart';

const String kHost = 'wft-geo-db.p.rapidapi.com';

Future<List<FindCityModel>> getFindCities(String cityPrefix, String languageCode) async {
  Uri uri = Uri.https(
    kHost,
    '/v1/geo/cities',
    {
      'namePrefix': cityPrefix,
      'languageCode': languageCode,
      'limit': '3',
      'sort': '-population'
    }
  );
  
  List<FindCityModel> cities = [];
  http.Response response = await http.get(uri, headers: {'x-rapidapi-key': '4ab072d9e2msh659b0d49c295a38p1e8378jsn44e9acb36f57'});

  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    
    for (Map<String, dynamic> data in body['data']) {
      cities.add(FindCityModel.fromJSON(data));
    }
  }

  return cities;
}