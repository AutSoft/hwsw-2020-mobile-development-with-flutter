import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockphotoapp/photo_data_store.dart';

import 'detailed_page.dart';
import 'detailed_page.dart';

class GridItemWidget extends StatelessWidget {
  final StockPhoto item;

  const GridItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (BuildContext context, void Function() action) {
        return GridTile(
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: item.id,
                  child: Image.network(
                    item.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: action
                  ),
                ),
              ),
            ],
          ),
        );
      },
      openBuilder: (BuildContext context, void Function({Object returnValue}) action) {
        return DetailedPage(photo: item,);
      },
    );

  }
}
