import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather_app/app/styles/typography.dart';
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/storage/storage.dart';
import 'package:weather_app/services/weather/payload/current_weather.dart';
import 'package:weather_app/services/weather/weather.dart';
import 'package:weather_app/views/pages/details/details.dart';

class LocationTile extends StatelessWidget {
  final LocationModel location;
  final void Function() onChange;

  const LocationTile({required this.location, required this.onChange, super.key});

  Future<void> deleteLocation(BuildContext context) async {
    StorageService storage = StorageService();
    await storage.deleteLocation(location.id);
    onChange();
  }

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

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsPage.route,
                arguments: DetailsPageParams(location, currentWeather)
              );
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: deleteLocation,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ]
              ),
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      currentWeather.isDay
                        ? 'assets/day/${currentWeather.image}.jpg'
                        : 'assets/night/${currentWeather.image}.jpg'
                    ),
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
                        Text(
                          location.city,
                          overflow: TextOverflow.ellipsis,
                          style: highlightWhite(22.0)
                        ),
                        Text('${currentWeather.temperature}º', style: highlightWhite(36.0))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentWeather.mainCondition, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Máx: ${currentWeather.maxTemperature}º Min: ${currentWeather.minTemperature}º', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
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