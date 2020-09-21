import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

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
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, -0.01)
                  ..rotateX(0.1)
                  ..translate(0.0, 0.0, 10.0),
                alignment: FractionalOffset.center,
                // TODO Apply a Transform widget around this container
                child: Container(
                  margin: const EdgeInsets.only(top: 28, left: 12, right: 12),
                  // TODO Add scrolling capability
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // TODO Add an Image with a progress indicator
                        Stack(
                          children: <Widget>[
                            Center(child: CircularProgressIndicator()),
                            Center(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: reviewImageUrl,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 400),
                          child: Text(
                            text,
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // TODO Add gradient overlay
          IgnorePointer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    stops: [0.2, 0.5],
                    colors: [Colors.black, Colors.transparent]),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
