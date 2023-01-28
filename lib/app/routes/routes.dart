import 'package:flutter/material.dart';
import 'package:weather_app/views/pages/details/details.dart';
import 'package:weather_app/views/pages/home/home.dart';

PageRouteBuilder generate(Widget page) {
  return PageRouteBuilder(pageBuilder: (_, __, ___) => page);
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  bool isRoute(String route) => settings.name == route;

  if (isRoute(HomePage.route)) {
    return generate(const HomePage());
  }

  if (isRoute(DetailsPage.route)) {
    DetailsPageParams params = settings.arguments as DetailsPageParams;
    return generate(DetailsPage(params: params));
  }

  return generate(const HomePage());
}