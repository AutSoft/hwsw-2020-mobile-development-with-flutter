import 'package:flutter/cupertino.dart';

class TemperatureIndicatorWidget extends StatelessWidget{
  final Widget icon;
  final double temperature;

  const TemperatureIndicatorWidget({Key key, this.icon, this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Text("$temperature C°")
      ],
    );
  }
}