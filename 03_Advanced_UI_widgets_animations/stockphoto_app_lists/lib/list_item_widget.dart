import 'package:flutter/material.dart';
import 'package:stockphotoapp/photo_data_store.dart';

import 'detailed_page.dart';

class ListItemWidget extends StatelessWidget {
  final StockPhoto item;

  const ListItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1 / 1,
          child: Image.network(
            item.url,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(item.title),
        subtitle: Text(
          item.description,
          maxLines: 1,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => DetailedPage(photo: item,)));
        },
      ),
    );
  }
}
