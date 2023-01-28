class CurrentWeatherModel {
  final String mainCondition;
  final String condition;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final double humidity;
  final double visibility;
  final double windSpeed;
  final double windAngle;
  final double clouds;
  final double rain;
  final double snow;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime localTime;

  const CurrentWeatherModel(this.mainCondition, this.condition, this.temperature, this.feelsLike, this.minTemperature, this.maxTemperature, this.humidity, this.visibility, this.windSpeed, this.windAngle, this.clouds, this.rain, this.snow, this.sunrise, this.sunset, this.localTime);

  factory CurrentWeatherModel.fromJSON(Map<String, dynamic> json) {
    String mainCondition = json['weather'][0]['main'];
    String condition = json['weather'][0]['description'];
    double temperature = json['main']['temp'] * 1.0;
    double feelsLike = json['main']['feels_like'] * 1.0;
    double minTemperature = json['main']['temp_min'] * 1.0;
    double maxTemperature = json['main']['temp_max'] * 1.0;
    double humidity = json['main']['humidity'] * 1.0;
    double visibility = json['visibility'] * 1.0;
    double windSpeed = json['wind']['speed'];
    double windAngle = json['wind']['deg'] * 1.0;
    double clouds = (json['clouds']?['all'] * 1.0) ?? 0.0;
    double rain = (json['rain']?['1h'] ?? 0.0) * 1.0;
    double snow = (json['snow']?['1h'] ?? 0.0) * 1.0;
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000);
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch + json['main']['temp'] * 1000).toInt());

    return CurrentWeatherModel(mainCondition, condition, temperature, feelsLike, minTemperature, maxTemperature, humidity, visibility, windSpeed, windAngle, clouds, rain, snow, sunrise, sunset, localTime);
  }

  double get windspeedKmh {
    double speed = windSpeed * 3.6;
    return double.parse(speed.toStringAsFixed(2));
  }

  int get visibilityKm {
    double distance = visibility / 1000;
    return distance.toInt();
  }

  bool get isDay {
    return localTime.isBefore(sunset) && localTime.isAfter(sunrise);
  }

  String get image {
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'cloud';
      case 'rain':
        return 'rain';
      case 'mist':
        return 'mist';
      case 'snow':
        return 'snow';
      default:
        return 'clear-sky';
    }
  }
}