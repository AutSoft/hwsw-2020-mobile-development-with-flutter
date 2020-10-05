import 'package:counter_app/counter_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
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
    print("Hello from build!");
    return BlocListener<CounterCubit, CounterState>(
      cubit: context.bloc(),
      listener: (oldState, newState){
        print("${(newState as CounterCount).count} $pageCount");
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CounterCubit, CounterState>(
            cubit: context.bloc(),
            builder: (context, state) {
              print("Inside title builder");
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
              BlocBuilder<CounterCubit, CounterState>(
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
          var cubit = BlocProvider.of<CounterCubit>(context);
          print("Inside buttons!");
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: cubit.increment,
                tooltip: 'Increment',
                child: Icon(Icons.add),
                heroTag: "inc",
              ),
              SizedBox(height: 8),
              FloatingActionButton(
                onPressed: cubit.decrement,
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
