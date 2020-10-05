import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountWidget(
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

class CountWidget extends StatefulWidget {
  final Widget child;

  const CountWidget({Key key, this.child}) : super(key: key);

  @override
  _CountWidgetState createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
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
    return CountHolderWidget(
      countWidgetState: this,
      countHolder: count,
      child: widget.child,
    );
  }
}

class CountHolderWidget extends InheritedWidget {
  final _CountWidgetState countWidgetState;
  final int countHolder;

  CountHolderWidget({Key key, this.countWidgetState, this.countHolder, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountHolderWidget oldWidget) => countHolder != oldWidget.countHolder;

  static _CountWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountHolderWidget>().countWidgetState;
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
          var count = CountHolderWidget.of(context).count;
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
              var count = CountHolderWidget.of(context).count;
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
        var countState = CountHolderWidget.of(context);
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
