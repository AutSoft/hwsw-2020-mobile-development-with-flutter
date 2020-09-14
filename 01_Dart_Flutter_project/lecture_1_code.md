# Dart bevezető

### Hello World
[DartPad](https://dartpad.dev/ff11838f11913e246e720a888acce2f3)
```dart
void main() {
  print("Hello World!");
}
```

### Változók deklarálása
[DartPad](https://dartpad.dev/cf2e353303fc7b6e5153ebd5b2b806dd)
```dart
bool globalFlag = false;

void main(List<String> args) {
  //Deklarálás inicializálással
  String myString = "My string";
  print(myString);
 
  //Deklarálás inicializálás nélkül
  String tempString;
  print(tempString);
  if (globalFlag){
    tempString = "True";
  } else {
    tempString = "False";
  }
  print(tempString);
 
  //Osztály inicializálás
  Duration myDuration = Duration();
  print(myDuration);
  
  String myNullString;
  print(myNullString ?? "Null variable!");
  //print(myNullString.length); !ERROR!
  print(myNullString?.length);
 
  var myAutoVar = "Automatic type";
  
  final myFinalVariable = "Hello";
  final myOtherFinalVariable = myAutoVar;
  const myConstVariable = "World!";
  //const myOtherConstVariable = myAutoVar; !ERROR!
}
```

### Változó típusok
[DartPad](https://dartpad.dev/ed3ff06eab7c266be72c9335b18ff6dc)
```dart
void main() {
  //Különbség int és double között
  int firstInt = 5;
  double firstDouble = 5;
  num firstNum = 5;
  print("Testing 5");
  print(firstInt.runtimeType);
  print(firstDouble.runtimeType);
  print(firstNum.runtimeType);
  
  //int secondInt = 5.0; !ERROR!
  double secondDouble = 5.0;
  num secondNum = 5.0;
  print("Testing 5.0");
  print(secondDouble.runtimeType);
  print(secondNum.runtimeType);
  
  double thirdDouble = 5.1;
  num thirdNum = 5.1;
  print("Testing 5.1");
  print(thirdDouble.runtimeType);
  print(thirdNum.runtimeType);
  
  //firstInt = firstDouble; !ERROR!
  //firstDouble = firstInt; !ERROR!
  firstInt = firstDouble.toInt();
  firstDouble = firstInt.toDouble();
  
  firstNum = firstInt;
  firstNum = firstDouble;
  
  //Int hossza
  print("Testing int length");
  print(1 << 31);
  print(1 << 32);
  
  bool testBool = true;
  
  //Null
  int nullInt = null;
  print("Null értékei");
  print(nullInt.runtimeType);
  print(nullInt.hashCode);
  print(nullInt.toString());
  //print(a.abs()); !ERROR!
  
  //Dynamic típus
  dynamic testDynamic;
  testDynamic = 5;
  print(testDynamic.runtimeType);
  testDynamic = "Hello Dynamic!";
  print(testDynamic.runtimeType);
  //testDynamic.gcd(3); !ERROR!
}
```

### Függvények
[DartPad](https://dartpad.dev/d9062516ed12df8e715a0910dd464b76)
```dart
void mySimpleFunction(){
  print("Függvényben");
  return;
}

int calculateSomeValue(int a, int b) => a + b;

void namedParametersFunction({String name, String description}){
  print("$name: $description");
}

positinalParametersFunction(int a, [int b]) => a + (b ?? 0);

lambdaParameterFunction (void Function (int a) lambda){
  lambda(10);
}

void main() {
  mySimpleFunction();
  print(calculateSomeValue(3,5));
  
  namedParametersFunction(name: "Dani");
  namedParametersFunction(description: "Hello", name: "Dani");
  
  print(positinalParametersFunction(3));
  print(positinalParametersFunction(3,4));
  
  void myLocalFunction(){
    print("Függvény a függvényben!");
    return;
  }
  myLocalFunction();
  
  var myLambdaExpression = (int a, int b) => print(a+b);
  myLambdaExpression(1,1);
  var myLambdaDetailedExpression = (){
    print("Inside lambda expression");
    return 1;
  };
  print(myLambdaDetailedExpression());
  print(myLambdaDetailedExpression.runtimeType);
  
  lambdaParameterFunction((int a){
    print(a);
  });
}
```

### Vezérlési struktúrák
[DartPad](https://dartpad.dev/02741c2e7f2f8592022a4fa27d609b05)
```dart
void main() {
  bool myFlag = true;
  if (myFlag){
    print("True");
  } else if (!myFlag) {
    print("False");
  } else {
    print("Null");
  }
  
  for (int i = 0; i < 4; i++){
    print(i);
  }
  
  for (var j = ""; j.length < 4; j += "a"){
    print(j);
  }
  
  var j = 0;
  while(j < 6){
    j++;
    if (j == 3)
      continue;
    print(j);
  }
  do{
    print("Do-while");
    break;
  } while(true);
  
  var myList = [3, 4, 7];
  for (var value in myList){
    print(value);
  }
  
  var mySwitchVariable = 'Hello';
  switch (mySwitchVariable) {
    case 'Hello':
      print("Első");
      break;
    case 'World':
      print("Második");
      break;
    case 'TEST':
      print("Minden más");
      break;
    default:
      print("Ismeretlen");
  }
  
  assert(mySwitchVariable != "Hello");
  
  String nullVariable;
  try{
    nullVariable.substring(0);
  } on NoSuchMethodError catch(e){
    print("Error caught!");
  } finally {
    print("Finally called!");
  }
}
```

### Sztring műveletek
[Dartpad](https://dartpad.dev/5f504d4a048008b5ce752c53289ad4ec)
```dart
void main() {
  //Sztring deklarálás
  var testSimpleString = "Hello World!";
  var testNewLineString = "Hello\r\nWorld!";
  var testNewLineRawString = r"Hello\r\nWorld!";
  var testMultiLineStringFirst = "Hello " +
    "World" +
    "!";
  var testMultiLineStringSecond = '''
  Hello
  World
  !
  ''';
  
  //Sztring műveletek
  var testString = "  12Hello World!34";
  print(testString.split(" "));
  print(testString.replaceFirst(" ", ""));
  print(testString.replaceAll(RegExp(r"\d"), ""));
  print(testString.padLeft(20));
  print(testString.toUpperCase());
  print(testString.trim());
  
  //Sztring interpoláció
  var myNumber = 36;
  print("Hello $myNumber!");
  print("Hello GCD: ${myNumber.gcd(28)}");
}
```

### List, Map, Set

[DartPad](https://dartpad.dev/42ee8b89b2805ff1b8edac5991c87eeb)
```dart
void main() {
  var myList = List();
  myList.add(5);
  myList.add("Hello");
  myList.add(Duration());
  print(myList);
  print(myList[1]);
  
  var myTypedList = List<String>();
  myTypedList.add("Hello");
  myTypedList.add("World!");
  //myTypedList.add(3); !ERROR!
  
  var myAutomaticList = [
    "World!",
    5,
    null
  ];
  print(myAutomaticList.runtimeType);
  
  var myIntList = [3, 5, 6, 18, 2];
  print(myIntList.length);
  print(myIntList.firstWhere((it) => it.isEven));
  print(myIntList.where((it) => it.isEven));
  //myIntList = myIntList.where((it) => true); !ERROR!
  myIntList.where((it){
    print("Inside where with: $it");
    return it.isEven;
  }).map((it){
    print("Inside map with: $it");
    return it.toString();
  }).firstWhere((it){
    print("Inside firstWhere with: $it");
    return it.length > 1;
  });
  print(myIntList.indexOf(8));
  //FONTOS! A dupla pont jelentése
  print(myIntList..retainWhere((it) => it.isEven));
  print(myIntList..sort((e1, e2) => e1.compareTo(e2)));
  //print(myIntList[5]); !ERROR!
  
  var myMap = {
    "test1" : 2,
    "test2" : 3,
    null : 2
  };
  print(myMap.runtimeType);
  print(myMap.keys);
  print(myMap.values);
  print(myMap.entries);
  
  var mySet = {1, 4, 6, 5, 4, 2, 1, 3};
  print(mySet);
  mySet.add(6);
  print(mySet);
  print(mySet.difference({4, 6, 9}));
  print(mySet.union({4, 6, 9}));
  print(mySet.intersection({4, 6, 9}));
  
  var whatIsThis = {};
  print(whatIsThis.runtimeType);
}
```

### Listák létrehozása feltételes kifejezésekkel

[DartPad](https://dartpad.dev/d87cea912ab2be236a30702713ba26b4)

```
import 'dart:math';

int testFunction(){
  return 4;
}

void main() {
  var myFirstList = [3, 5, 9];
  var mySecondList = [1, 2, 4, 5];
  print(myFirstList + mySecondList);
  myFirstList.addAll(mySecondList);
  print(myFirstList);
  
  var itemFlag = true;
  var myDetailedList = [
    1,
    itemFlag ? 2 : 9,
    if (itemFlag)
      3,
    testFunction(),
    for(int j = 5; j < 6; j++)
      j,
    ...myFirstList,
    ...mySecondList.map((it) => it + 1),
    for (int j = 11; j < 13; j++)
      ...[
        j,
        j * 2,
      ],
    for (var item in mySecondList)
      (){
        for (int i = 0; i < 10; i++){
          if (item == pow(2, i))
            return 0;
        }
        return item;
      }(),
  ];
  print(myDetailedList);
  
  //var myGenerator = ...[3, 2, 1]; !ERROR!
}
```
### Osztályok
[DartPad](https://dartpad.dev/51a9b8cc3b6cd4b9e673490d894ee468)
```dart
class PointClass{
  double x;
  double y;
  
  PointClass(double x, double y){
    this.x = x;
    this.y = y;
  }
  
  @override
  String toString(){
    return "PointClass(x: $x, y: $y)";
  }
}

class ConstPointClass{
  final double x;
  final double y;
  
  const ConstPointClass(double x, double y) : this.x = x, this.y = y;
  
  @override
  String toString(){
    return "ConstPointClass(x: $x, y: $y)";
  }
}

class VectorClass{
  double x;
  double y;
  
  VectorClass(this.x, this.y);
  VectorClass.zero() : this(0, 0);
  
  static final List<VectorClass> _poolList = [];
  factory VectorClass.pooled(){
    if (_poolList.isNotEmpty){
      return _poolList.removeLast()
        ..x = 0
        ..y = 0;
    } else {
      return VectorClass.zero();
    }
  }
  void recycle(){
    _poolList.add(this);
  }
  
  
  @override
  String toString(){
    return "VectorClass(x: $x, y: $y)";
  }
  
  @override
  int get hashCode => x.hashCode ^ y.hashCode;
  
  @override
  operator ==(dynamic other) => other is VectorClass && other.x == x && other.y == y;
  
  operator +(VectorClass other) => VectorClass(x + other.x, y + other.y);
}

enum Colors{
  RED, BLUE, GREEN
}

abstract class Listenable{
  void addListener(void Function(dynamic));
  void notifyListeners();
}
class ListenableInt extends Listenable{
  int value;
  @override
  void addListener(void Function(dynamic) Function) {
    // TODO: implement addListener
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }
}


mixin Phoner{
  phoneMessage(String msg) => print("Phoning message: $msg");
}

mixin Receiver{
  receiveMessage() => "Hello phone!";
}

class MessageHolder with Phoner{
  final String message;
  
  MessageHolder(this.message);
  
  phoneMyMessage() => phoneMessage(message);
}

class ExtendedMessageHolder extends MessageHolder with Receiver {
  final String date;
  ExtendedMessageHolder(String message, this.date) : super(message);
  
  @override
  phoneMyMessage() => phoneMessage("$date - $message");
}

extension SafeListGetter<T> on List<T>{
  T getOrNull(int index) => this != null && index < this.length ? this[index] : null;  
}

void main(){
  var point1 = PointClass(1, 2);
  var point2 = PointClass(1, 2);
  print(point1);
  print(point1 == point2);
  
  var constPoint1 = const ConstPointClass(1, 2);
  var constPoint2 = const ConstPointClass(1, 2);
  print(constPoint1);
  print(constPoint1 == constPoint2);
  
  var vector1 = VectorClass(1, 2);
  var vector2 = VectorClass(1, 2);
  print(vector1);
  print(vector1 == vector2);
  print(vector1 + vector2);
  vector1 += vector2;
  
  var color = Colors.BLUE;
  print(color.index);
  print(color);
  
  var messageHolder = MessageHolder("Hello World!");
  messageHolder.phoneMyMessage();
  
  var extendedMessageHolder = ExtendedMessageHolder("Hello", "Tuesday");
  extendedMessageHolder.phoneMyMessage();
  print(extendedMessageHolder.receiveMessage());
  
  List<int> myList;
  print(myList.getOrNull(4));
}
```

### Első Flutter app
[DartPad](https://dartpad.dev/8ae8f95821527267b67da3e23b52e9ed)
```dart
import 'package:flutter/widgets.dart';

void main() => runApp(
  Container(
    color: Color.fromRGBO(200, 200, 200, 1.0),
    child: Row(
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          "https://pbs.twimg.com/profile_images/685483654/favicon_160_400x400.png",
          width: 90,
        ),
        Text(
          "Hello Flutter",
          style: const TextStyle(),
          textDirection: TextDirection.ltr,
        ),
      ],
    ),
  ),
);```

### Widget tree működése
[DartPad](https://dartpad.dev/051f27819a923597d3994c71ac69fce6)
```dart
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(ColorTestApp());

class ColorTestApp extends StatefulWidget{
  @override
  _ColorTestAppState createState() => _ColorTestAppState();
}

class _ColorTestAppState extends State<ColorTestApp> {
  List<Widget> colorsWidget;

  @override
  void initState() {
    colorsWidget = [
      StatefulColorWidget(key: UniqueKey()),
      StatefulColorWidget(key: UniqueKey()),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ...colorsWidget,
            RaisedButton(
              child: Text("Switch widgets"),
              onPressed: (){
                setState(() {
                  colorsWidget = colorsWidget.reversed.toList();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class StatelessColorWidget extends StatelessWidget {
  final Color color;

  const StatelessColorWidget({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 200,
      height: 100,
    );
  }
}

class StatefulColorWidget extends StatefulWidget {
  final Color color;

  const StatefulColorWidget({Key key, this.color}) : super(key: key);

  @override
  _StatefulColorWidgetState createState() => _StatefulColorWidgetState();
}

class _StatefulColorWidgetState extends State<StatefulColorWidget> {
  Color color;

  @override
  void initState() {
    color = Color(Random().nextInt(1 << 24)).withOpacity(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 200,
      height: 100,
    );
  }
}
```

### InheritedWidget
[Dartpad](https://dartpad.dev/2c0ef15c36c689c871af3716c1dded8e)
```dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(InheritedTestApp());

class InheritedTestApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyStateWidget(
            child: MyRowWidget(
              children: [
                MyCounterLabel(),
                MyCounterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyStateWidget extends StatefulWidget{
  final Widget child;

  const MyStateWidget({Key key, this.child}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyStateWidget> {
  var count = 0;

  void increaseCount(){
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyStateInheritWidget(
      child: widget.child,
      value: this,
    );
  }
}

class MyStateInheritWidget extends InheritedWidget{
  final _MyState value;
  final Widget child;

  MyStateInheritWidget({Key key, this.value, this.child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyStateInheritWidget oldWidget) => true;

  static _MyState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MyStateInheritWidget>().value;
}

class MyRowWidget extends StatelessWidget{
  final List<Widget> children;

  const MyRowWidget({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: this.children,
    );
  }
}

class MyCounterLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var count = MyStateInheritWidget.of(context).count;
    return Text(
      count.toString()
    );
  }
}

class MyCounterButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Press me"),
      onPressed: (){
        MyStateInheritWidget.of(context).increaseCount();
      },
    );
  }
}
```