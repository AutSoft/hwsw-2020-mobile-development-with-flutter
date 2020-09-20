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