import 'package:flutter/material.dart';

class CardsDemo extends StatelessWidget {
  // TODO Add a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
      key: scaffoldKey,
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
                    elevation: 8,
                    // TODO Add a shape
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Material(
                      // TODO Add shape
                      shape: CircleBorder(),
                      color: entry.value,
                      child: InkWell(
                        onTap: () {
                          // TODO Show a SnackBar
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("${entry.key} clicked!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
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
