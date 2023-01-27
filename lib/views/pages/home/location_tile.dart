import 'package:flutter/material.dart';
import 'package:weather_app/app/styles/typography.dart';
import 'package:weather_app/services/storage/payload/location.dart';

class LocationTile extends StatelessWidget {
  final LocationModel location;

  const LocationTile({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
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
              Text('3º', style: highlightWhite(36.0))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Muito Nublado', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Máx: 6º Min: 0º', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}