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
  final queryTextController = TextEditingController();

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
        // TODO Add 8 px padding with a Padding widget and a background color with a Container and 16 px padding
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${_MIN_PRICE.round()} MFt"),
                    Expanded(
                      // TODO Add a Slider row for price range
                      // TODO Change the Slider to a RangeSlider
                      child: RangeSlider(
                        values: RangeValues(_minPriceValue, _maxPriceValue),
                        min: _MIN_PRICE,
                        max: _MAX_PRICE,
                        divisions: 30,
                        labels: RangeLabels(
                            "${_minPriceValue.round().toString()} MFt",
                            "${_maxPriceValue.round().toString()} MFt"),
                        onChanged: (values) {
                          setMinPriceValue(values.start);
                          setMaxPriceValue(values.end);
                        },
                      ),
                    ),
                    Text("${_MAX_PRICE.round()} MFt"),
                  ],
                ),
                // TODO Add a Switch row to show the date picker row
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
                // TODO Add a DatePicker row for soonest moving in date
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
                    : Row(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      // TODO Add a RaisedButton with an icon for the search action
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
    // TODO Dispose the created TextFieldController
    queryTextController.dispose();
    super.dispose();
  }
}
