import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigationsample/second_page.dart';

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Icon(
              Icons.android,
              color: Colors.lightGreenAccent,
              size: 120,
            ),
            SizedBox(height: 16),
            Text("This is the first page"),
            RaisedButton(
              child: Text("Navigate to other page"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
              },
            ),
            RaisedButton(
              child: Text("Back"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
