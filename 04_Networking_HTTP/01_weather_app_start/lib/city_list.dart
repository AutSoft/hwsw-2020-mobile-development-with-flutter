import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/city_detailed.dart';
import 'package:weatherapp/city_list_item.dart';

class CityListPage extends StatelessWidget {
  //TODO: download list from network
  //TODO: refresh list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City list"),
      ),
      body: ListView(
        children: [
          CityListItem(
            name: "Budapest",
            windDegree: 130,
            windMagnitude: 5.2,
            imageUrl: "http://openweathermap.org/img/wn/10d@2x.png",
            temperature: 25.2,
            feelTemperature: 22.4,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => CityDetailedPage(cityId: 0,)));
            },
          ),
        ],
      ),
    );
  }
}
