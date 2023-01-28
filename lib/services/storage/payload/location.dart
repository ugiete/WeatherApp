class LocationModel {
  final int id;
  final String city;
  final String regionCode;
  final String country;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  const LocationModel(this.id, this.city, this.regionCode, this.country, this.latitude, this.longitude, this.isFavorite);

  factory LocationModel.fromJSON(Map<String, dynamic> json) {
    int id = json['id'];
    String city = json['city'].split(',')[0];
    String regionCode = json['regionCode'];
    String country = json['country'];
    double latitude = json['latitude'];
    double longitude = json['longitude'];
    bool isFavorite = json['isFavorite'] ?? false;

    return LocationModel(id, city, regionCode, country, latitude, longitude, isFavorite);
  }

  Map<String, dynamic> get toMap => {
    'id': id,
    'city': city,
    'regionCode': regionCode,
    'country': country,
    'latitude': latitude,
    'longitude': longitude,
    'isFavorite': isFavorite
  };
}