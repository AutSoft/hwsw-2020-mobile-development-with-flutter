import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        pageCount: 1,
        globalState: this,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int pageCount;
  final _MyAppState globalState;
  const MyHomePage({Key key, this.pageCount, this.globalState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page count: $pageCount, Counter: ${globalState.count}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${globalState.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyHomePage(
                      pageCount: pageCount + 1,
                      globalState: globalState,
                    ),
                  ),
                );
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
            onPressed: globalState.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
            heroTag: "inc",
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: globalState.decrement,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
            heroTag: "dec",
          ),
        ],
      ),
    );
  }
}
