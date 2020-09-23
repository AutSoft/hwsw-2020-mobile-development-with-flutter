import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weatherapp/models.dart';

const _API_KEY = r"e6932dac2b4ba21c31ba22d19f4ecc56";

const _oneCityRequestUrl = r"http://api.openweathermap.org/data/2.5/find?lat=47.4701997&lon=19.0585203&cnt=1&units=metric&lang=hu&appid=" + _API_KEY;
const _forecastRequestUrl = r"https://api.openweathermap.org/data/2.5/onecall?lat=47.4701997&lon=19.0585203&units=metric&lang=hu&exclude=minutely,hourly,alerts&appid=" + _API_KEY;

Future<http.Response> startFetchOneCity() => http.get(_oneCityRequestUrl).then(
      (value) {
        print(value.body);
        return value;
      },
    );

/*List<dynamic> _parseResponseForCurrentItems(String body) {
  var json = jsonDecode(body);
  for (int i = 0; i < 300000000; i++) {}
  var resultList = json["list"] as List<dynamic>;
  return resultList;
}

Future<List<WeatherCurrentItem>> startFetchCities() async {
  await Future.delayed(Duration(seconds: 1));
  var response = await http.get(_citiesRequestUrl);
  if (response.statusCode ~/ 100 != 2) {
    throw response.body;
  }
  var parsed = await compute(_parseResponseForCurrentItems, response.body);
  return parsed.map((element) => WeatherCurrentItem.fromJson(element)).toList();
}*/

class RemoteDioService {
  Dio _dio;

  RemoteDioService() {
    _dio = Dio(BaseOptions(baseUrl: "http://api.openweathermap.org/data/2.5/", queryParameters: {"appid": _API_KEY, "units": "metric", "lang": "hu"}));
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<List<WeatherCurrentItem>> startFetchCities() async {
    await Future.delayed(Duration(seconds: 1));
    var response = await _dio.get(
      "group",
      queryParameters: {
        "id" : "1634318,2740615,3062159,6425514,6461050,655722,75327091,8012541,8277210,2864708,2056851,2644701,3048326,3054638,3046526,721472,3042929",
      },
    );
    if (response.statusCode ~/ 100 != 2) {
      throw response.data;
    }
    var result = (response.data["list"] as List<dynamic>).map((element) => WeatherCurrentItem.fromJson(element)).toList();
    return result;
  }
}
var remoteDio = RemoteDioService();