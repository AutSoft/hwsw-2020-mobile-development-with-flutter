// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$WeatherService extends WeatherService {
  _$WeatherService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WeatherService;

  @override
  Future<Response<WeatherCurrentListResponse>> fetchCities(
      {String id =
          "1634318,2740615,3062159,6425514,6461050,655722,75327091,8012541,8277210,2864708,2056851,2644701,3048326,3054638,3046526,721472,3042929"}) {
    final $url = 'http://api.openweathermap.org/data/2.5/group';
    final $params = <String, dynamic>{'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<WeatherCurrentListResponse, WeatherCurrentListResponse>($request);
  }
}
