import 'package:flutter/material.dart';

import 'first_page.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            FlutterLogo(
              size: 120,
            ),
            SizedBox(height: 16),
            Text("This is the second page"),
            RaisedButton(
              child: Text("Navigate to other page"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SecondPage()),
                );
              },
            ),
            RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
