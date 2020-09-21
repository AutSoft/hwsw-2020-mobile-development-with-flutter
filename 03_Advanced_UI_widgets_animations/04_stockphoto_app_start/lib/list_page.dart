import 'package:flutter/material.dart';
import 'package:stockphotoapp/detailed_page.dart';
import 'package:stockphotoapp/photo_data_store.dart';

class ListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List view"),),
      body: Center(
        child: Column(
          children: [
            ...Iterable.generate(10, (id){
              var item = StockPhoto.fromId(id);
              return RaisedButton(
                child: Text(item.title),
                onPressed: (){
                  //TODO: Navigate to detailed page
                },
              );
            })
          ],
        ),
      ),
    );
  }
}