import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forum/ui/login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInitializer());
}

class FirebaseInitializer extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to initialize Firebase. :(",
                textDirection: TextDirection.ltr,
              ),
            );
          }

          if (snapshot.hasData) {
            return FlutterForumApp();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class FlutterForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterForum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}