import 'package:flutter/material.dart';
import 'package:weather_app/app/styles/typography.dart';
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/weather/payload/current_weather.dart';
import 'package:weather_app/services/weather/weather.dart';

class LocationTile extends StatelessWidget {
  final LocationModel location;

  const LocationTile({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentWeather(location),
      builder: (BuildContext context, AsyncSnapshot<CurrentWeatherModel?> snapshot) {
        if (snapshot.hasError || (snapshot.connectionState == ConnectionState.done && !snapshot.hasData)) {
          return Container();
        }

        if (snapshot.hasData) {
          CurrentWeatherModel currentWeather = snapshot.data!;

          return Container(
            height: 100,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage('http://static1.squarespace.com/static/5ac3533bb27e39f181f34a32/t/60a67a9324c06f7ab8f7ea2e/1621523101366/unsplash-image-8iZG31eXkks.jpg?format=1500w'),
                opacity: 0.5,
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(location.city, style: highlightWhite(22.0)),
                    Text('${currentWeather.temperature}º', style: highlightWhite(36.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currentWeather.condition, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Máx: ${currentWeather.maxTemperature}º Min: ${currentWeather.minTemperature}º', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          );
        }

        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}