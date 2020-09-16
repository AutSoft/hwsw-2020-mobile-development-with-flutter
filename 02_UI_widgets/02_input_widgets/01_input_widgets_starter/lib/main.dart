import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Real Estate Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RealEstateSearchFormPage(title: 'Flutter Real Estate Search'),
    );
  }
}

class RealEstateSearchFormPage extends StatefulWidget {
  RealEstateSearchFormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RealEstateSearchFormPageState createState() =>
      _RealEstateSearchFormPageState();
}

class _RealEstateSearchFormPageState extends State<RealEstateSearchFormPage> {
  // TODO Add state variables

  // TODO Add a TextEditingController to access TextField data

  // TODO Implement state updating methods for state variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // TODO Add 8 px padding with a Padding widget and a background color by a Container and 16 px padding
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search query",
            textAlign: TextAlign.start,
          ),
          // TODO Add a TextField row for query text with a TextEditingController
          Text("TextField row placeholder"),
          // TODO Implement a Checkbox row for filtering newly built houses
          Text("Checkbox row placeholder"),
          // TODO Add 2 Radio rows (grouped) for "for sale"/"for rent"
          Text("Radio group placeholder"),
          // TODO Add a Slider row for price range of MIN_PRICE to MAX_PRICE
          // TODO Change the Slider to a RangeSlider
          Text("Slider slider placeholder"),
          // TODO Add a Switch row to show or hide the date picker row
          Text("Switch row placeholder"),
          /* TODO Add a row that acts as a date chooser, opening a DatePicker when a button is clicked
          * and that displays the selected date as the soonest moving in date.
          * This row must only be displayed when the previous switch is ON.
          */
          Text("Date chooser placeholder"),
          // TODO Add row with a RaisedButton having an icon for the search action
          Text("RaisedButton row placeholder")
        ],
      ),
    );
  }

  // TODO Implement this method to show a DatePicker and save the selected date as state
  void showSoonestMovingDatePicker() async {
    print("TODO show a DatePicker");
  }

  @override
  void dispose() {
    // TODO Dispose the previously created TextFieldController
    print("Dispose any created TextFieldControllers");
    super.dispose();
  }
}
