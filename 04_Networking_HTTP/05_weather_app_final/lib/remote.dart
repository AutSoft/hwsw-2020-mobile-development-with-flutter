import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weatherapp/models.dart';

part 'remote.chopper.dart';

const _API_KEY = r"e6932dac2b4ba21c31ba22d19f4ecc56";

const _oneCityRequestUrl = r"http://api.openweathermap.org/data/2.5/find?lat=47.4701997&lon=19.0585203&cnt=1&units=metric&lang=hu&appid=" + _API_KEY;
const _forecastRequestUrl = r"https://api.openweathermap.org/data/2.5/onecall?lat=47.4701997&lon=19.0585203&units=metric&lang=hu&exclude=minutely,hourly,alerts&appid=" + _API_KEY;

/*Future<http.Response> startFetchOneCity() => http.get(_oneCityRequestUrl).then(
      (value) {
        print(value.body);
        return value;
      },
    );
*/
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

/*class RemoteDioService {
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
var remoteDio = RemoteDioService();*/

@ChopperApi(baseUrl: "http://api.openweathermap.org/data/2.5/")
abstract class WeatherService extends ChopperService {
  static WeatherService create([ChopperClient client]) => _$WeatherService(client);

  @Get(path: "group")
  Future<Response<WeatherCurrentListResponse>> fetchCities({@Query("id") String id = "1634318,2740615,3062159,6425514,6461050,655722,75327091,8012541,8277210,2864708,2056851,2644701,3048326,3054638,3046526,721472,3042929"});

  @Get(path: "onecall")
  Future<Response<WeatherForecastListResponse>> fetchForecast(@Query("lat") num latitude, @Query("lon") num longitude, [@Query("exclude") String exclude="current,minutely,hourly,alerts"]);
}

class RemoteChopper {
  ChopperClient _client;

  RemoteChopper() {
    _client = ChopperClient(
      services: [WeatherService.create()],
      interceptors: [
        (Request request) {
          var map = request.parameters?.map((key, value) => MapEntry(key, value)) ?? {};
          map["appid"] = _API_KEY;
          map["units"] = "metric";
          map["lang"] = "hu";
          return request.copyWith(parameters: map);
        },
      ],
      converter: JsonSerializableConverter({
        WeatherCurrentListResponse: WeatherCurrentListResponse.fromJsonFactory,
        WeatherForecastListResponse: WeatherForecastListResponse.fromJsonFactory,
      }),
      errorConverter: JsonConverter(),
    );
  }

  Future<List<WeatherCurrentItem>> startFetchCities() async {
    await Future.delayed(Duration(seconds: 1));
    var service = _client.getService<WeatherService>();
    var response = await service.fetchCities();
    if (response.statusCode ~/ 100 != 2) {
      throw response.error;
    }
    return response.body.list;
  }

  Future<WeatherCurrentItem> startFetchCity(int id) async {
    var service = _client.getService<WeatherService>();
    var response = await service.fetchCities(id: "$id");
    if (response.statusCode ~/ 100 != 2){
      throw response.error;
    }
    return response.body.list[0];
  }

  Future<List<WeatherForecastItem>> startFetchDailyForecast(num lat, num lon) async {
    var service = _client.getService<WeatherService>();
    var response = await service.fetchForecast(lat, lon);
    if (response.statusCode ~/ 100 != 2){
      throw response.error;
    }
    return response.body.daily;
  }
}

typedef T JsonFactory<T>(Map<String, dynamic> json);
class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  JsonSerializableConverter(this.factories);

  T _decodeMap<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }
    return jsonFactory(values);
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity);
    if (entity is Map) return _decodeMap<T>(entity);
    return entity;
  }
  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    // use [JsonConverter] to decode json
    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }
  @override
  // all objects should implements toJson method
  Request convertRequest(Request request) => super.convertRequest(request);
  Response convertError<ResultType, Item>(Response response) {
    // use [JsonConverter] to decode json
    final jsonRes = super.convertError(response);

    return jsonRes;
  }
}

var remoteChopper = RemoteChopper();
