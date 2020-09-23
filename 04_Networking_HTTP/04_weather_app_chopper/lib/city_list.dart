import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/city_detailed.dart';
import 'package:weatherapp/city_list_item.dart';
import 'package:weatherapp/models.dart';
import 'package:weatherapp/remote.dart';

class CityListPage extends StatefulWidget {
  //TODO: download list from network
  //TODO: refresh list

  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  Future<List<WeatherCurrentItem>> weatherCurrentItemsRequest;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList(){
    setState(() {
      weatherCurrentItemsRequest = remoteChopper.startFetchCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City list"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchList();
          await weatherCurrentItemsRequest;
        },
        child: FutureBuilder<List<WeatherCurrentItem>>(
          future: weatherCurrentItemsRequest,
          builder: (BuildContext context, AsyncSnapshot<List<WeatherCurrentItem>> snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var item = items[index];
                  return CityListItem(
                    name: item.name,
                    windDegree: item.wind.deg,
                    windMagnitude: item.wind.speed,
                    imageUrl: item.weather.length != 0 ? "http://openweathermap.org/img/wn/${item.weather[0].icon}@2x.png" : null,
                    temperature: item.main.temp,
                    feelTemperature: item.main.feels_like,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CityDetailedPage(
                            cityId: item.id,
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: items.length,
              );
            } else if (snapshot.hasError) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text("Caught error: ${snapshot.error}"),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
