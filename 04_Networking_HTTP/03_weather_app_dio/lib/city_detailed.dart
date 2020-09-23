import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weatherapp/models.dart';
import 'package:weatherapp/widgets.dart';


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed page"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Text(
              "Budapest",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32,),
            Image.network("http://openweathermap.org/img/wn/10d@2x.png"),
            Text("Jelenlegi idő:"),
            TemperatureIndicatorWidget(
              icon: Icon(Icons.ac_unit, size: 32,),
              temperature: 24.3,
            ),
            SizedBox(height: 4),
            TemperatureIndicatorWidget(
              icon: Icon(Icons.person, size: 32,),
              temperature: 22.3,
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
                      [DateTime(2020, 09, 23), 24.5],
                      [DateTime(2020, 09, 24), 22.5],
                      [DateTime(2020, 09, 25), 23.5],
                      [DateTime(2020, 09, 26), 24.5],
                      [DateTime(2020, 09, 27), 23.5],
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
        ),
      ),
    );
  }
}
