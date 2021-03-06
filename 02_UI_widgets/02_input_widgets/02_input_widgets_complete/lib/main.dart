import 'package:flutter/material.dart';

import 'util.dart';

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
  bool _isNewlyBuiltChecked = false;

  bool _isShowingDetailedSearch = false;

  PropertySearchType _propertySearchType = PropertySearchType.forSale;

  double _minPriceValue = MIN_PRICE;

  double _maxPriceValue = MAX_PRICE;

  DateTime _soonestMovingInDate = DateTime.now();

  // TODO Add a TextEditingController to access TextField data
  final queryTextController = TextEditingController();

  // TODO Implement state updating methods for state variables
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
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search query",
                  textAlign: TextAlign.start,
                ),
                // TODO Add a TextField row for query text with a TextEditingController
                TextField(
                  decoration: InputDecoration(hintText: "City, Street, etc."),
                  controller: queryTextController,
                ),
                Row(
                  children: [
                    // TODO Implement a Checkbox row for filtering newly built houses
                    Checkbox(
                      value: _isNewlyBuiltChecked,
                      onChanged: (checked) {
                        setNewlyBuiltChecked(checked);
                      },
                    ),
                    Text("Only newly built properties")
                  ],
                ),
                // TODO Add 2 Radio rows (grouped) for "for sale"/"for rent"
                Row(
                  children: [
                    Radio(
                      value: PropertySearchType.forSale,
                      groupValue: _propertySearchType,
                      onChanged: (value) {
                        setPropertySearchType(PropertySearchType.forSale);
                      },
                    ),
                    Text("For sale"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: PropertySearchType.forRent,
                      groupValue: _propertySearchType,
                      onChanged: (value) {
                        setPropertySearchType(PropertySearchType.forRent);
                      },
                    ),
                    Text("For rent"),
                  ],
                ),
                // TODO Add a Slider row for price range of MIN_PRICE to MAX_PRICE
                // TODO Change the Slider to a RangeSlider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${MIN_PRICE.round()} MFt"),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_minPriceValue, _maxPriceValue),
                        min: MIN_PRICE,
                        max: MAX_PRICE,
                        divisions: 30,
                        labels: RangeLabels(
                          "${_minPriceValue.round().toString()} MFt",
                          "${_maxPriceValue.round().toString()} MFt",
                        ),
                        onChanged: (values) {
                          setMinPriceValue(values.start);
                          setMaxPriceValue(values.end);
                        },
                      ),
                    ),
                    Text("${MAX_PRICE.round()} MFt"),
                  ],
                ),
                // TODO Add a Switch row to show or hide the date picker row
                Row(
                  children: [
                    Text("Show more options"),
                    Switch(
                        value: _isShowingDetailedSearch,
                        onChanged: (value) {
                          showDetailedSearch(value);
                        })
                  ],
                ),
                /* TODO Add a row that acts as a date chooser, opening a DatePicker when a button is clicked
                * and that displays the selected date as the soonest moving in date.
                * This row must only be displayed when the previous switch is ON.
                */
                (_isShowingDetailedSearch)
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Text("Soonest moving in date:"),
                          ),
                          Text(getFormattedDate(_soonestMovingInDate)),
                          FlatButton(
                            child: Text("SELECT DATE"),
                            onPressed: showSoonestMovingDatePicker,
                          )
                        ],
                      )
                    : Container(),
                // TODO Add a RaisedButton having an icon for the search action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: RaisedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        label: Text("SEARCH"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO Implement this method to show a DatePicker and save the selected date as state
  void showSoonestMovingDatePicker() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
    );
    setSoonestMovingInDate(date);
  }

  @override
  void dispose() {
    // TODO Dispose the previously created TextFieldController
    queryTextController.dispose();
    super.dispose();
  }
}
