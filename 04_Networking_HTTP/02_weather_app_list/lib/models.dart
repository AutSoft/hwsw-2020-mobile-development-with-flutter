import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class WeatherCurrentItem{
  final int id;
  final String name;
  final Coordinate coord;
  final MainWeatherData main;
  final WindData wind;
  final List<WeatherStatus> weather;

  WeatherCurrentItem(this.id, this.name, this.coord, this.main, this.wind, this.weather);

  factory WeatherCurrentItem.fromJson(Map<String, dynamic> json) => _$WeatherCurrentItemFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherCurrentItemToJson(this);
}

@JsonSerializable()
class WeatherForecastItem{
  final TemperatureData temp;
  final TemperatureData feels_like;

  WeatherForecastItem(this.temp, this.feels_like);

  factory WeatherForecastItem.fromJson(Map<String, dynamic> json) => _$WeatherForecastItemFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastItemToJson(this);
}

@JsonSerializable()
class Coordinate{
  final num lat;
  final num lon;

  Coordinate(this.lat, this.lon);

  factory Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}

@JsonSerializable()
class MainWeatherData{
  final num temp;
  final num feels_like;
  final num temp_min;
  final num temp_max;
  final num pressure;
  final num humidity;

  MainWeatherData(this.temp, this.feels_like, this.temp_min, this.temp_max, this.pressure, this.humidity);

  factory MainWeatherData.fromJson(Map<String, dynamic> json) => _$MainWeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$MainWeatherDataToJson(this);
}

@JsonSerializable()
class WindData{
  final num speed;
  final num deg;

  WindData(this.speed, this.deg);

  factory WindData.fromJson(Map<String, dynamic> json) => _$WindDataFromJson(json);
  Map<String, dynamic> toJson() => _$WindDataToJson(this);
}

@JsonSerializable()
class WeatherStatus{
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherStatus(this.id, this.main, this.description, this.icon);

  factory WeatherStatus.fromJson(Map<String, dynamic> json) => _$WeatherStatusFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherStatusToJson(this);
}

@JsonSerializable()
class TemperatureData{
  final num day;
  final num min;
  final num max;
  final num night;
  final num eve;
  final num morn;

  TemperatureData(this.day, this.min, this.max, this.night, this.eve, this.morn);

  factory TemperatureData.fromJson(Map<String, dynamic> json) => _$TemperatureDataFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureDataToJson(this);
}