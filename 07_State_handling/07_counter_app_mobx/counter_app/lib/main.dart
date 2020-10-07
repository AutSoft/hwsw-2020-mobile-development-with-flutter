import 'package:counter_app/count_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CountStore(),
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

class MyHomePage extends StatelessWidget {
  final int pageCount;

  const MyHomePage({Key key, this.pageCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<CountStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (context) {
            return Text("Page count: $pageCount, Counter: ${store.count}");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (context) {
                return Text(
                  '${store.count}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: store.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
              heroTag: "inc",
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              onPressed: store.decrement,
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
