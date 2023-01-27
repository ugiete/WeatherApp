import 'package:flutter/material.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/services/storage/storage.dart';

void main() {
  StorageService storageService = StorageService();
  runApp(const WeatherApp());
}