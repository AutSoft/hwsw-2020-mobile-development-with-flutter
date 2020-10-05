import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(pageCount: 1,),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int pageCount;

  const MyHomePage({Key key, this.pageCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page count: $pageCount"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(pageCount: pageCount + 1,)));
              },
              child: Text("To next page"),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: null,
            tooltip: 'Increment',
            child: Icon(Icons.add),
            heroTag: "inc",
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: null,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
            heroTag: "dec",
          ),
        ],
      ),
    );
  }
}
