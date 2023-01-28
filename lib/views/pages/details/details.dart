import 'package:flutter/material.dart';
import 'package:weather_app/app/styles/typography.dart';
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/weather/payload/current_weather.dart';
import 'package:weather_app/views/layouts/default.dart';
import 'package:weather_app/views/pages/details/feature_box.dart';

class DetailsPageParams {
  final LocationModel location;
  final CurrentWeatherModel initalWeather;

  const DetailsPageParams(this.location, this.initalWeather);
}

class DetailsPage extends StatefulWidget {
  final LocationModel location;
  final CurrentWeatherModel initalWeather;

  DetailsPage({required DetailsPageParams params, super.key})
    : location = params.location,
      initalWeather = params.initalWeather;

  static String get route => '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late CurrentWeatherModel currentWeather;

  @override
  void initState() {
    currentWeather = widget.initalWeather;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundImage: currentWeather.isDay
        ? 'assets/day/${currentWeather.image}.jpg'
        : 'assets/night/${currentWeather.image}.jpg',
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: [
          const SizedBox(height: 50),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.location.city, textAlign: TextAlign.center, style: highlightWhite(40)),
              Text('${currentWeather.temperature}º', style: highlightWhite(60)),
              Text(currentWeather.condition, style: highlightWhite(20)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: GridView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
              children: [
                FeatureBox(
                  icon: Icons.thermostat,
                  title: 'Feels Like',
                  data: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${currentWeather.feelsLike}º', style: highlightWhite(36))
                      ],
                    ),
                  )
                ),
                FeatureBox(
                  icon: Icons.wind_power_outlined,
                  title: 'Wind',
                  data: Expanded(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(currentWeather.windAngle / 360),
                      child: const Icon(Icons.arrow_downward, size: 80, color: Colors.white),
                    ),
                  ),
                  description: Text(
                    '${currentWeather.windspeedKmh} km/h',
                    style: highlightWhite(16)
                  )
                ),
                FeatureBox(
                  icon: Icons.water_rounded,
                  title: 'Humidity',
                  data: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${currentWeather.humidity}%', style: highlightWhite(36))
                      ],
                    ),
                  )
                ),
                FeatureBox(
                  icon: Icons.visibility,
                  title: 'Visibility',
                  data: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${currentWeather.visibilityKm}km', style: highlightWhite(36))
                      ],
                    ),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}