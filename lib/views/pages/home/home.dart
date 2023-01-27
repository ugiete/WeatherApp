import 'package:flutter/material.dart';
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/storage/storage.dart';
import 'package:weather_app/views/layouts/default.dart';
import 'package:weather_app/views/pages/home/location_tile.dart';
import 'package:weather_app/views/pages/home/search_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int suggestionsLength = 0;
  List<LocationModel> locations = [];

  void onChangeSuggestions(int length) {
    setState(() {
      suggestionsLength = length;
    });
  }

  Future<void> loadSavedLocations() async {
    StorageService storage = StorageService();
    List<LocationModel> savedLocations = await storage.readAllLocations();

    setState(() {
      locations = savedLocations;
    });
  }

  @override
  void initState() {
    loadSavedLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      header: SearchAppBar(
        suggestionsLength: suggestionsLength,
        onChange: onChangeSuggestions,
        onSelect: loadSavedLocations,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            const SizedBox(height: 15.0),
            ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: locations.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: LocationTile(location: locations[index]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}