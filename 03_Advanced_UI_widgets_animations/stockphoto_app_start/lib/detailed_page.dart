import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockphotoapp/photo_data_store.dart';

class DetailedPage extends StatelessWidget{
  final StockPhoto photo;

  const DetailedPage({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(photo.title),),
      body: Column(
        children: [
          //TODO: Fix image pop in
          Image.network(photo.url),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              photo.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              photo.description,
              style: TextStyle(
                fontSize: 14
              ),
            ),
          )
        ],
      ),
    );
  }
}