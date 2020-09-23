// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCurrentItem _$WeatherCurrentItemFromJson(Map<String, dynamic> json) {
  return WeatherCurrentItem(
    json['id'] as int,
    json['name'] as String,
    json['coord'] == null
        ? null
        : Coordinate.fromJson(json['coord'] as Map<String, dynamic>),
    json['main'] == null
        ? null
        : MainWeatherData.fromJson(json['main'] as Map<String, dynamic>),
    json['wind'] == null
        ? null
        : WindData.fromJson(json['wind'] as Map<String, dynamic>),
    (json['weather'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WeatherCurrentItemToJson(WeatherCurrentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
      'main': instance.main,
      'wind': instance.wind,
      'weather': instance.weather,
    };

WeatherForecastItem _$WeatherForecastItemFromJson(Map<String, dynamic> json) {
  return WeatherForecastItem(
    json['temp'] == null
        ? null
        : TemperatureData.fromJson(json['temp'] as Map<String, dynamic>),
    json['feels_like'] == null
        ? null
        : TemperatureData.fromJson(json['feels_like'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeatherForecastItemToJson(
        WeatherForecastItem instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) {
  return Coordinate(
    json['lat'] as num,
    json['lon'] as num,
  );
}

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

MainWeatherData _$MainWeatherDataFromJson(Map<String, dynamic> json) {
  return MainWeatherData(
    json['temp'] as num,
    json['feels_like'] as num,
    json['temp_min'] as num,
    json['temp_max'] as num,
    json['pressure'] as num,
    json['humidity'] as num,
  );
}

Map<String, dynamic> _$MainWeatherDataToJson(MainWeatherData instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

WindData _$WindDataFromJson(Map<String, dynamic> json) {
  return WindData(
    json['speed'] as num,
    json['deg'] as num,
  );
}

Map<String, dynamic> _$WindDataToJson(WindData instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

WeatherStatus _$WeatherStatusFromJson(Map<String, dynamic> json) {
  return WeatherStatus(
    json['id'] as int,
    json['main'] as String,
    json['description'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$WeatherStatusToJson(WeatherStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

TemperatureData _$TemperatureDataFromJson(Map<String, dynamic> json) {
  return TemperatureData(
    json['day'] as num,
    json['min'] as num,
    json['max'] as num,
    json['night'] as num,
    json['eve'] as num,
    json['morn'] as num,
  );
}

Map<String, dynamic> _$TemperatureDataToJson(TemperatureData instance) =>
    <String, dynamic>{
      'day': instance.day,
      'min': instance.min,
      'max': instance.max,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

WeatherCurrentListResponse _$WeatherCurrentListResponseFromJson(
    Map<String, dynamic> json) {
  return WeatherCurrentListResponse(
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherCurrentItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WeatherCurrentListResponseToJson(
        WeatherCurrentListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

WeatherForecastListResponse _$WeatherForecastListResponseFromJson(
    Map<String, dynamic> json) {
  return WeatherForecastListResponse(
    (json['daily'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherForecastItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WeatherForecastListResponseToJson(
        WeatherForecastListResponse instance) =>
    <String, dynamic>{
      'daily': instance.daily,
    };
