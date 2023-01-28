import 'package:flutter/material.dart';
import 'package:weather_app/app/routes/routes.dart';
import 'package:weather_app/views/pages/home/home.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: HomePage.route,
    );
  }
}