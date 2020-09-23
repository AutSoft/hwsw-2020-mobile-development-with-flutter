import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weatherapp/models.dart';
import 'package:weatherapp/widgets.dart';
import 'package:weatherapp/remote.dart';


class _CityDetailedPageData{
  final WeatherCurrentItem currentItem;
  final List<WeatherForecastItem> forecastItems;

  _CityDetailedPageData(this.currentItem, this.forecastItems);
}

class CityDetailedPage extends StatefulWidget {
  final int cityId;
  const CityDetailedPage({Key key, this.cityId}) : super(key: key);

  @override
  _CityDetailedPageState createState() => _CityDetailedPageState();
}

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
