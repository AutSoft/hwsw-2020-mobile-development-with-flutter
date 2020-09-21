###Navigator

```dart
return WillPopScope(
  onWillPop: () async {
	var result = await showDialog(
		context: context,
		builder: (context) {
		  return AlertDialog(
			title: Text("Are you sure?"),
			content: Text("Do you really want to quit?"),
			actions: [
			  FlatButton(
				child: Text("No"),
				onPressed: () => Navigator.pop(context, false),
			  ),
			  FlatButton(
				child: Text("Yes"),
				onPressed: () => Navigator.pop(context, true),
			  ),
			],
		  );
		});
	return result ?? false;
  },
  child: Scaffold(),
);
```

```dart
  RaisedButton(
	child: Text("Go to first page"),
	onPressed: () {
	  Navigator.push(
		context,
		MaterialPageRoute(
		  builder: (context) => FirstPage(),
		  settings: RouteSettings(
			name: "firstPage",
			arguments: null
		  ),
		),
	  );
	},
  ),
```

```dart
      routes: {
        "/firstpage": (context) => FirstPage(),
        "/secondpage": (context) => SecondPage(),
      },
      onGenerateRoute: (route){
        /*switch(route.name){
          case "/parameterpage":
            return MaterialPageRoute(builder: (context) => ParameterPage(parameter: route.arguments.toString(),));
        }*/
        return null;
      },
      onUnknownRoute: (route){
        return MaterialPageRoute(builder: (_) => ParameterPage(parameter: route.toString()));
      },
```

###Stockphoto

```dart
          //TODO: Fix image pop in
          AspectRatio(
            aspectRatio: 600 / 400,
            child: Image.network(
              photo.url,
              loadingBuilder: (context, child, loading) {
                if (loading == null){
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
```

```dart
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
```

```dart
      /*body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ...Iterable.generate(100, (id){
                var item = StockPhoto.fromId(id);
                return ListItemWidget(item: item,);
              })
            ],
          ),
        ),
      ),*/
      /*body: ListView(
        children: [
          ...Iterable.generate(100000, (id){
            var item = StockPhoto.fromId(id);
            return ListItemWidget(item: item,);
          })
        ],
      ),*/
      /*body: ListView.builder(
        itemBuilder: (context, index){
          var item = StockPhoto.fromId(index);
          return ListItemWidget(item: item);
        },
      )*/
      body: ListView.separated(
        itemBuilder: (context, index) {
          var item = StockPhoto.fromId(index);
          return ListItemWidget(item: item);
        },
        separatorBuilder: (context, index) => Container(
          height: 16,
          alignment: Alignment.center,
          child: Container(
            height: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        itemCount: 1000000,
      ),
```

```dart
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
```

