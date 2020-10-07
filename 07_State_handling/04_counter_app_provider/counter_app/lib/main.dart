import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          pageCount: 1,
        ),
      ),
    );
  }
}

class CountState extends ChangeNotifier{
  int count = 0;

  void increment(){
    count++;
    notifyListeners();
  }

  void decrement(){
    count--;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  final int pageCount;

  const MyHomePage({Key key, this.pageCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Hello from build!");
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          print("Inside title builder!");
          var count = Provider.of<CountState>(context).count;
          return Text("Page count: $pageCount, Counter: $count");
        }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Builder(builder: (context) {
              var count = Provider.of<CountState>(context).count;
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyHomePage(
                      pageCount: pageCount + 1,
                    ),
                  ),
                );
              },
              child: Text("To next page"),
            )
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        var countState = Provider.of<CountState>(context, listen: false);
        print("Inside buttons!");
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: countState.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
              heroTag: "inc",
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              onPressed: countState.decrement,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
              heroTag: "dec",
            ),
          ],
        );
      }),
    );
  }
}
