import 'package:flutter/material.dart';

import 'data/datasource_provider.dart';
import 'ui/list/todo_list.dart';

void main() {
  runApp(AwesomeTodoApp());
}

class AwesomeTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataSourceProvider(
      child: AppDependencyProvider()
    );
  }
}

class AppDependencyProvider extends StatefulWidget {
  @override
  _AppDependencyProviderState createState() => _AppDependencyProviderState();
}

class _AppDependencyProviderState extends State<AppDependencyProvider> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AwesomeTodoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(
        dataSource: DataSourceProvider.of(context).dataSource,
      ),
    );
  }
}



