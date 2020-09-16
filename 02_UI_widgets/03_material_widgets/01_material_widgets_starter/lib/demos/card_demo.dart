import 'package:flutter/material.dart';

class CardsDemo extends StatelessWidget {
  // TODO Add a GlobalKey for the Scaffold

  final cardSize = 200.0;

  final Map<String, Color> items = {
    "CYAN": Colors.cyan,
    "YELLOW": Colors.yellow,
    "MAGENTA": Colors.pink,
    "BLACK": Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO Add a key to the Scaffold
      // https://medium.com/@ksheremet/flutter-showing-snackbar-within-the-widget-that-builds-a-scaffold-3a817635aeb2
      appBar: AppBar(
        title: Text("Material Cards Demo"),
      ),
      body: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.entries
              .map(
                (entry) => SizedBox(
                  width: cardSize,
                  height: cardSize,
                  child: Card(
                    // TODO Add elevation
                    // TODO Add a shape
                    child: Material(
                      // TODO Add shape
                      shape: CircleBorder(),
                      color: entry.value,
                      child: InkWell(
                        onTap: () {
                          // TODO Show a SnackBar
                        },
                      ),
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
