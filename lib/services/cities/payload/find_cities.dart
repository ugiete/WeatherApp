class FindCityModel {
  final int id;
  final String wikiDataId;
  final String type;
  final String city;
  final String name;
  final String country;
  final String countryCode;
  final String region;
  final String regionCode;
  final double latitude;
  final double longitude;
  final int population;

  const FindCityModel(this.id, this.wikiDataId, this.type, this.city, this.name, this.country, this.countryCode, this.region, this.regionCode, this.latitude, this.longitude, this.population);

  factory FindCityModel.fromJSON(Map<String, dynamic> json) {
    int id = json['id'];
    String wikiDataId = json['wikiDataId'];
    String type = json['type'];
    String city = json['city'];
    String name = json['name'];
    String country = json['country'];
    String countryCode = json['countryCode'];
    String region = json['region'];
    String regionCode = json['regionCode'];
    double latitude = json['latitude'];
    double longitude = json['longitude'];
    int population = json['population'];

    return FindCityModel(id, wikiDataId, type, city, name, country, countryCode, region, regionCode, latitude, longitude, population);
  }

  String get description => '$city, $regionCode - $country';

  Map<String, dynamic> get toMap => {
    'id': id,
    'city': city,
    'country': country,
    'regionCode': regionCode,
    'latitude': latitude,
    'longitude': longitude
  };
}