
### Future bevezetés
```dart
Future<String> myLongRunningFunction() => Future.delayed(
  Duration(seconds: 3),
  (){
    print("Inside the future");
    throw Exception("No internet connection!");
    return "Hello in the future!";
  },
);

void main() {
  print("Starting main");
  var futureResult = myLongRunningFunction();
  print("Immediate result: $futureResult");
  futureResult.then(
    (result){
      print("Result of function: $result");
    },
  ).timeout(
    Duration(
      seconds: 1,
    ),
  ).catchError(
    (error){
      print("Caught error: $error");
    },
  ).whenComplete(
    (){
      print("Inside whenComplete");
    }
  );
  var i = 0;
  /*while(true){
    for (int j = 0; j < 1000; j++)
      print("${i++}");
  } !!FREEZES!!*/ 
  print("Ending main");
}
```

### Future async-al
```dart
Future<String> myLongRunningFunction() => Future.delayed(
  Duration(seconds: 3),
  (){
    print("Inside the future");
    throw Exception("No internet connection!");
    return "Hello in the future!";
  },
);

void myAsyncFunc() async {
  print("Starting async func");
  try{
    var result = await myLongRunningFunction();
    print("Immediate result: $result");
  } catch(e) {
    print("Caught error: $e");
  } finally {
    print("Inside finally");
  }
}
```

### Weather app
```dart
Future<http.Response> startFetchOneCity() => http.get(_oneCityRequestUrl).then(
      (value) {
        print(value.body);
        return value;
      },
    );


class _CityListPageState extends State<CityListPage> {
  dynamic city;

  @override
  void initState() {
    startFetchOneCity().then((value) {
      setState(() {
        var jsonMap = jsonDecode(value.body);
        city = jsonMap["list"][0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City list"),
      ),
      body: ListView(
        children: [
          if (city != null)
            CityListItem(
              name: city["name"],
              windDegree: city["wind"]["deg"],
              windMagnitude: city["wind"]["speed"],
              imageUrl: "http://openweathermap.org/img/wn/01d@2x.png",
              temperature: 25.2,
              feelTemperature: 22.4,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => CityDetailedPage(cityId: 0,)));
              },
            ),
        ],
      ),
    );
  }
}

```dart
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.0
  weather_icons: 2.0.1
  charts_flutter: ^0.9.0
  http: ^0.12.2
  json_annotation: ^3.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^1.10.2
  json_serializable: ^3.4.1
  
dependency_overrides:
  analyzer: '0.39.14'
```

```dart
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
```

```dart
class _CityListPageState extends State<CityListPage> {
  Future<List<WeatherCurrentItem>> weatherCurrentItemsRequest;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList(){
    setState(() {
      weatherCurrentItemsRequest = startFetchCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City list"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchList();
          await weatherCurrentItemsRequest;
        },
        child: FutureBuilder<List<WeatherCurrentItem>>(
          future: weatherCurrentItemsRequest,
          builder: (BuildContext context, AsyncSnapshot<List<WeatherCurrentItem>> snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var item = items[index];
                  return CityListItem(
                    name: item.name,
                    windDegree: item.wind.deg,
                    windMagnitude: item.wind.speed,
                    imageUrl: item.weather.length != 0 ? "http://openweathermap.org/img/wn/${item.weather[0].icon}@2x.png" : null,
                    temperature: item.main.temp,
                    feelTemperature: item.main.feels_like,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CityDetailedPage(
                            cityId: item.id,
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: items.length,
              );
            } else if (snapshot.hasError) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text("Caught error: ${snapshot.error}"),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
```

```
List<dynamic> _parseResponseForCurrentItems(String body){
  var json = jsonDecode(body);
  for (int i = 0; i < 300000000; i++){
  }
  var resultList = json["list"] as List<dynamic>;
  return resultList;
}

Future<List<WeatherCurrentItem>> startFetchCities() async{
  await Future.delayed(Duration(seconds: 1));
  var response = await http.get(_citiesRequestUrl);
  if (response.statusCode ~/ 100 != 2){
    throw response.body;
  }
  var parsed = await compute(_parseResponseForCurrentItems, response.body);
  return parsed.map((element) => WeatherCurrentItem.fromJson(element)).toList();
}
```

```dart
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
```

```dart
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
```

```dart
class _CityDetailedPageState extends State<CityDetailedPage> {
  Future<_CityDetailedPageData> _dataRequest;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async{
    setState(() {
      _dataRequest = Future(() async{
        var cityResponse = await remoteChopper.startFetchCity(widget.cityId);
        var forecastResponse = await remoteChopper.startFetchDailyForecast(cityResponse.coord.lat, cityResponse.coord.lon);
        return _CityDetailedPageData(cityResponse, forecastResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed page"),
      ),
      body: Center(
        child: FutureBuilder<_CityDetailedPageData>(
          future: _dataRequest,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  SizedBox(height: 8,),
                  Text(
                    data.currentItem.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 32,),
                  Image.network("http://openweathermap.org/img/wn/${data.currentItem.weather[0].icon}@2x.png"),
                  Text("Jelenlegi idő:"),
                  TemperatureIndicatorWidget(
                    icon: Icon(Icons.ac_unit, size: 32,),
                    temperature: data.currentItem.main.temp,
                  ),
                  SizedBox(height: 4),
                  TemperatureIndicatorWidget(
                    icon: Icon(Icons.person, size: 32,),
                    temperature: data.currentItem.main.feels_like,
                  ),
                  Container(
                    height: 300,
                    child: charts.TimeSeriesChart(
                      [
                        charts.Series<dynamic, DateTime>(
                            id: 'Előrejelzés',
                            colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
                            domainFn: (dynamic value, _) => value[0],
                            measureFn: (dynamic value, _) => value[1],
                            data: [
                              for (int i = 0; i < data.forecastItems.length; i++)
                                [DateTime.now().add(Duration(days: i + 1)), data.forecastItems[i].temp.day],
                            ]
                        )
                      ],
                      defaultRenderer: charts.LineRendererConfig(includePoints: true),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                          tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)
                      ),
                      animate: false,
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}

```