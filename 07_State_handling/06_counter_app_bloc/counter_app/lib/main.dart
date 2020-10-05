import 'package:counter_app/counter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
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
    return BlocListener<CounterBloc, CounterState>(
      cubit: context.bloc(),
      listener: (oldState, newState){
        print("${(newState as CounterCount).count} $pageCount");
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CounterBloc, CounterState>(
            cubit: context.bloc(),
            builder: (context, state) {
              var text;
              if (state is CounterInitial) {
                text = "Initial";
              } else {
                text = (state as CounterCount)?.count ?? "";
              }
              return Text("Page count: $pageCount, Counter: $text");
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
              BlocBuilder<CounterBloc, CounterState>(
                cubit: context.bloc(),
                builder: (context, state) {
                  var text;
                  if (state is CounterInitial) {
                    text = "Initial";
                  } else {
                    text = (state as CounterCount).count;
                  }
                  return Text(
                    '$text',
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
          var cubit = context.bloc<CounterBloc>();
          print("Inside buttons!");
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () => cubit.add(CounterIncrement()),
                tooltip: 'Increment',
                child: Icon(Icons.add),
                heroTag: "inc",
              ),
              SizedBox(height: 8),
              FloatingActionButton(
                onPressed: () => cubit.add(CounterDecrement()),
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
                heroTag: "dec",
              ),
            ],
          );
        }),
      ),
    );
  }
}
