import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/widgets.dart';

class CityListItem extends StatelessWidget {
  final String name;
  final num windDegree;
  final num windMagnitude;
  final String imageUrl;
  final num temperature;
  final num feelTemperature;
  final VoidCallback onTap;

  const CityListItem({Key key, this.name, this.windDegree, this.windMagnitude, this.imageUrl, this.temperature, this.feelTemperature, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TemperatureIndicatorWidget(
                        icon: Icon(Icons.ac_unit, size: 18,),
                        temperature: temperature,
                      ),
                      SizedBox(width: 8),
                      TemperatureIndicatorWidget(
                        icon: Icon(Icons.person, size: 18),
                        temperature: feelTemperature,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WindIcon(degree: windDegree),
                    Text("$windMagnitude m/s"),
                  ],
                ),
              ),
            ),
            Material(
              shape: Theme.of(context).cardTheme.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}