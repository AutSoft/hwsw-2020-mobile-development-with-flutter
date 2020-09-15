import 'package:flutter/material.dart';
import 'package:material_widgets/demos/navigation_widgets_demo.dart';
import 'package:material_widgets/demos/tabs_demo.dart';
import 'package:material_widgets/demos/scrolling_demo.dart';

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
      home: showDemoContent(Demo._04_NAVIGATION_WIDGETS),
    );
  }
}

Widget showDemoContent(Demo demo) {
  switch (demo) {
    case Demo._01_CARDS:
      return CardsDemo();
    case Demo._02_SCROLLING:
      return ScrollingDemo();
    case Demo._03_TABS:
      return TabsDemo();
    case Demo._04_NAVIGATION_WIDGETS:
      return NavigationWidgetsDemo();
  }
}

enum Demo {
  _01_CARDS,
  _02_SCROLLING,
  _03_TABS,
  _04_NAVIGATION_WIDGETS,
}
