import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockphotoapp/photo_data_store.dart';

import 'detailed_page.dart';

class GridItemWidget extends StatelessWidget{
  final StockPhoto item;

  const GridItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              item.url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DetailedPage(photo: item,)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}