class WeatherCurrentItem{
  final int id;
  final String name;
  final Coordinate coord;
  final MainWeatherData main;
  final WindData wind;
  final List<WeatherStatus> weather;

  WeatherCurrentItem(this.id, this.name, this.coord, this.main, this.wind, this.weather);
}

class WeatherForecastItem{
  final TemperatureData temp;
  final TemperatureData feels_like;

  WeatherForecastItem(this.temp, this.feels_like);
}

class Coordinate{
  final num lat;
  final num lon;

  Coordinate(this.lat, this.lon);
}

class MainWeatherData{
  final num temp;
  final num feels_like;
  final num temp_min;
  final num temp_max;
  final num pressure;
  final num humidity;

  MainWeatherData(this.temp, this.feels_like, this.temp_min, this.temp_max, this.pressure, this.humidity);
}

class WindData{
  final num speed;
  final num deg;

  WindData(this.speed, this.deg);
}

class WeatherStatus{
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherStatus(this.id, this.main, this.description, this.icon);
}

class TemperatureData{
  final num day;
  final num min;
  final num max;
  final num night;
  final num eve;
  final num morn;

  TemperatureData(this.day, this.min, this.max, this.night, this.eve, this.morn);
}