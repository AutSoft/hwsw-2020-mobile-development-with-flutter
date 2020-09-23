import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models.dart';

const _API_KEY = r"e6932dac2b4ba21c31ba22d19f4ecc56";

const _oneCityRequestUrl = r"http://api.openweathermap.org/data/2.5/find?lat=47.4701997&lon=19.0585203&cnt=1&units=metric&lang=hu&appid=" + _API_KEY;
const _citiesRequestUrl = r"http://api.openweathermap.org/data/2.5/group?id=1634318,2740615,3062159,6425514,6461050,655722,75327091,8012541,8277210,2864708,2056851,2644701,3048326,3054638,3046526,721472,3042929&units=metric&lang=hu&appid=" + _API_KEY;
const _forecastRequestUrl = r"https://api.openweathermap.org/data/2.5/onecall?lat=47.4701997&lon=19.0585203&units=metric&lang=hu&exclude=minutely,hourly,alerts&appid=" + _API_KEY;

Future<http.Response> startFetchOneCity() => http.get(_oneCityRequestUrl).then(
      (value) {
        print(value.body);
        return value;
      },
    );

Future<List<WeatherCurrentItem>> startFetchCities() async{
  await Future.delayed(Duration(seconds: 1));
  var response = await http.get(_citiesRequestUrl);
  if (response.statusCode ~/ 100 != 2){
    throw response.body;
  }
  var json = jsonDecode(response.body);
  var resultList = json["list"] as List<dynamic>;
  return resultList.map((element) => WeatherCurrentItem.fromJson(element)).toList();
}