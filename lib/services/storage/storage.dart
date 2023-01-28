import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/services/storage/payload/location.dart';

class StorageService {
  final FlutterSecureStorage storage;

  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal() : storage = const FlutterSecureStorage();

  Future<void> writeLocation(LocationModel location) async {
    await storage.write(key: 'loc-${location.id}', value: jsonEncode(location.toMap));
  }
  
  Future<LocationModel?> readLocation(int id) async {
    String? data = await storage.read(key: 'loc-$id');

    return data != null ? LocationModel.fromJSON(jsonDecode(data)) : null;
  }

  Future<List<LocationModel>> readAllLocations() async {
    Map<String, String> data = await storage.readAll();

    List<LocationModel> locations = [];
    
    for (String object in data.values) {
      locations.add(LocationModel.fromJSON(jsonDecode(object)));
    }

    return locations;
  }

  Future<void> deleteLocation(int id) async {
    await storage.delete(key: 'loc-$id');
  }
}