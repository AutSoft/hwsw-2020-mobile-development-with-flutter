import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../demo.dart';

class ScrollingDemo extends StatefulWidget {
  @override
  _ScrollingDemoState createState() => _ScrollingDemoState();
}

class _ScrollingDemoState extends State<ScrollingDemo> {
  @override
  Widget build(BuildContext context) {
    final text = review;

    return Scaffold(
      appBar: AppBar(
        title: Text("Scrolling Demo"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          // TODO Apply a Transform widget around this container
          child: Container(
            margin: const EdgeInsets.only(top: 28, left: 12, right: 12),
            // TODO Add scrolling capability
            child: Column(
              children: <Widget>[
                // TODO Add an Image with a progress indicator
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 400),
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // TODO Add gradient overlay
    );
  }
}
