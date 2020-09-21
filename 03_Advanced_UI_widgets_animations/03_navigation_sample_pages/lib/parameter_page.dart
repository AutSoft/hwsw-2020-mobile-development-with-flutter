import 'package:flutter/material.dart';

class ParameterPage extends StatelessWidget {
  final String parameter;

  const ParameterPage({Key key, this.parameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parameter page")),
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
            Text("This is the parameter page"),
            Text("Parameter value: $parameter"),
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
