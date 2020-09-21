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

```dart
      /*body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: [
          ...Iterable.generate(
            100000,
            (id) {
              var item = StockPhoto.fromId(id);
              return Hero(
                tag: id,
                child: GridItemWidget(
                  item: item,
                ),
              );
            },
          )
        ],
      ),*/
      /*body: GridView.extent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1 / 1,
        children: [
          ...Iterable.generate(
            100000,
                (id) {
              var item = StockPhoto.fromId(id);
              return GridItemWidget(
                item: item,
              );
            },
          )
        ],
      )*/
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (context, index) {
          var item = StockPhoto.fromId(index);
          return GridItemWidget(item: item);
        },
      ),
```

```dart
class _ListItemWidgetState extends State<ListItemWidget> {
  bool liked;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1 / 1,
          child: Image.network(
            widget.item.url,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.item.title),
        subtitle: Text(
          widget.item.description,
          maxLines: 1,
        ),
        trailing: GestureDetector(
          onTap: () => setState(
            () {
              if (liked == null) {
                liked = true;
              } else {
                liked = !liked;
              }
            },
          ),
          child: AnimatedTheme(
            duration: Duration(seconds: 2),
            data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: liked == null ? null : (liked ? Colors.green : Colors.red),
                  ),
            ),
            child: Icon(
              Icons.thumb_up,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailedPage(
                photo: widget.item,
              ),
            ),
          );
        },
      ),
    );
  }
}
```

```dart
child: AnimatedRotation(
            duration: Duration(seconds: 2),
            curve: Curves.easeIn,
            angle: (liked == null ? 1 : (liked ? 0 : 2)) * pi / 2,
            child: AnimatedTheme(
              duration: Duration(seconds: 2),
              data: Theme.of(context).copyWith(
                iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: liked == null ? null : (liked ? Colors.green : Colors.red),
                    ),
              ),
              child: Icon(
                Icons.thumb_up,
              ),
            ),
          ),


class AnimatedRotation extends ImplicitlyAnimatedWidget {
  final double angle;
  final Widget child;

  AnimatedRotation({this.angle, this.child, @required Duration duration, @required Curve curve, Key key}) : super(key: key, duration: duration, curve: curve);

  @override
  _AnimatedRotationState createState() => _AnimatedRotationState();
}

class _AnimatedRotationState extends AnimatedWidgetBaseState<AnimatedRotation> {
  Tween<double> _angleTween;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angleTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _angleTween = visitor(_angleTween, widget.angle, (dynamic value) => Tween<double>(begin: value));
  }
}
```

```dart
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: liked == null ? 1 : (liked ? 0 : 2)),
            builder: (BuildContext context, double value, Widget child) {
              return Transform.rotate(
                angle: value * pi / 2,
                child: child,
              );
            },
            duration: Duration(seconds: 2),
            child: AnimatedTheme(
              duration: Duration(seconds: 2),
              data: Theme.of(context).copyWith(
                iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: liked == null ? null : (liked ? Colors.green : Colors.red),
                    ),
              ),
              child: Icon(
                Icons.thumb_up,
              ),
            ),
          ),
```

```dart
class LikeButton extends StatefulWidget{
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2), value: 0.5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (controller.status == AnimationStatus.forward || controller.status == AnimationStatus.completed){
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: RotationTransition(
        turns: controller.drive(Tween(begin: 0, end: 0.5)),
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Icon(
              Icons.thumb_up,
              color: ColorTween(begin: Colors.green, end: Colors.red).evaluate(controller),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```
