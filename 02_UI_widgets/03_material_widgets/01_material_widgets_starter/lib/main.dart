import 'package:flutter/material.dart';
import 'package:material_widgets/demos/navigation_widgets_demo.dart';
import 'package:material_widgets/demos/tabs_demo.dart';
import 'package:material_widgets/demos/scrolling_demo.dart';

import 'demo.dart';
import 'demos/card_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: showDemoContent(Demo.d01_CARDS),
    );
  }
}

Widget showDemoContent(Demo demo) {
  switch (demo) {
    case Demo.d01_CARDS:
      return CardsDemo();
    case Demo.d02_SCROLLING:
      return ScrollingDemo();
    case Demo.d03_TABS:
      return TabsDemo();
    case Demo.d04_NAVIGATION_WIDGETS:
      return NavigationWidgetsDemo();
    default:
      return Container();
  }
}
