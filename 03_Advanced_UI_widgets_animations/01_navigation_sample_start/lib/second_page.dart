import 'package:flutter/material.dart';

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
            FlutterLogo(size: 120,),
            SizedBox(height: 16),
            Text("This is the second page"),
            RaisedButton(
              child: Text("Navigate to other page"),
              onPressed: () {
                //TODO: Try out different navigations
              },
            ),
            RaisedButton(
              child: Text("Back"),
              onPressed: (){
                //TODO: Handle back button
              },
            ),
          ],
        ),
      ),
    );
  }
}
