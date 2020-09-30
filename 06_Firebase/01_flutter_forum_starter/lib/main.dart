import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_forum/ui/login/login_page.dart';
import 'package:flutter_forum/ui/posts/posts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInitializer());
}

class FirebaseInitializer extends StatelessWidget {
  final Future<FirebaseApp> _initialization = initFirebase();

  static Future<FirebaseApp> initFirebase() async {
    // TODO Initialize FlutterFire (Firebase)
    final firebaseInitialization = await Firebase.initializeApp();
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
    return firebaseInitialization;
  }

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
      home: HomeScreenRenderer(),
    );
  }
}

class HomeScreenRenderer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) {
        return FirebaseAuth.instance.currentUser != null;
      },
      widgetBuilder: (context) => PostsPage(),
      fallbackBuilder: (context) => LoginPage(),
    );
  }
}
