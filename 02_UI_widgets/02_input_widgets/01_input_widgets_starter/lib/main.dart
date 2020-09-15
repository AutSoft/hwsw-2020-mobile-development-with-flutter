import 'package:flutter/material.dart';
import 'package:flutter_form/util.dart';

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

const double _MIN_PRICE = 0;

const double _MAX_PRICE = 150;

enum PropertySearchType { forSale, forRent }

class _RealEstateSearchFormPageState extends State<RealEstateSearchFormPage> {
  bool _isNewlyBuiltChecked = false;

  bool _isShowingDetailedSearch = false;

  PropertySearchType _propertySearchType = PropertySearchType.forSale;

  double _minPriceValue = _MIN_PRICE;

  double _maxPriceValue = _MAX_PRICE;

  DateTime _soonestMovingInDate = DateTime.now();

  // TODO Add a TextEditingController to access TextField data

  void showDetailedSearch(bool show) {
    setState(() {
      _isShowingDetailedSearch = show;
    });
  }

  void setNewlyBuiltChecked(bool checked) {
    setState(() {
      _isNewlyBuiltChecked = checked;
    });
  }

  void setPropertySearchType(PropertySearchType type) {
    setState(() {
      _propertySearchType = type;
    });
  }

  void setMinPriceValue(double value) {
    setState(() {
      _minPriceValue = value;
    });
  }

  void setMaxPriceValue(double value) {
    setState(() {
      _maxPriceValue = value;
    });
  }

  void setSoonestMovingInDate(DateTime date) {
    setState(() {
      if (date == null) {
        _soonestMovingInDate = DateTime.now();
      } else {
        _soonestMovingInDate = date;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // TODO Add 8 px padding with a Padding widget and a background color by a Container and 16 px padding
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${_MIN_PRICE.round()} MFt"),
                Expanded(
                  // TODO Add a Slider for price range of _MIN_PRICE to _MAX_PRICE
                  // TODO Change the Slider to a RangeSlider
                  child: Text("Slider placeholder"),
                ),
                Text("${_MAX_PRICE.round()} MFt"),
              ],
            ),
            // TODO Add a Switch row to show or hide the date picker row
            Text("Switch row placeholder"),
            /* TODO Add a row that acts as a date chooser, opening a DatePicker when a button is clicked
            * and that displays the selected date as the soonest moving in date.
            * This row must only be displayed when the previous switch is ON.
            */
            (_isShowingDetailedSearch) ? Row() : Row(),
            // TODO Add row with a RaisedButton with an icon for the search action
            Text("RaisedButton row placeholder")
          ],
        ),
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
