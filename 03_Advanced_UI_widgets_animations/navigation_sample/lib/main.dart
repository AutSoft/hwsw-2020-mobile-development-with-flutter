import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigationsample/first_page.dart';
import 'package:navigationsample/parameter_page.dart';
import 'package:navigationsample/second_page.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/firstpage": (context) => FirstPage(),
        "/secondpage": (context) => SecondPage(),
      },
      onGenerateRoute: (route){
        /*switch(route.name){
          case "/parameterpage":
            return MaterialPageRoute(builder: (context) => ParameterPage(parameter: route.arguments.toString(),));
        }*/
        return null;
      },
      onUnknownRoute: (route){
        return MaterialPageRoute(builder: (_) => ParameterPage(parameter: route.toString()));
      },
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: handle back button, confirm quit
    return WillPopScope(
      onWillPop: () async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you really want to quit?"),
                actions: [
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              );
            });
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Main page")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("This is the main page!"),
              RaisedButton(
                child: Text("Go to first page"),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/firstpage"
                  );
                },
              ),
              RaisedButton(
                child: Text("Go to second page"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/secondpage");
                },
              ),
              RaisedButton(
                child: Text("Go to parameter page"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/parameterpage", arguments: "Hello");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
