# 06 Firebase

# Preparations

What's Firebase?

Why is it good for us?

## FlutterFire libraries

https://firebase.flutter.dev/

## Creating a Firebase project for our app

https://console.firebase.google.com/

## Platform Setup

1. [Android Installation](https://firebase.flutter.dev/docs/installation/android).

   - Create an Android project in the Firebase project
     - SHA-1
       - `./gradlew signingReport`
     - Download `google-services.json` and put it into the *android/app* folder

   - Enable multidex
     - minSdkVersion 16 -> minSdkVersion 21

2. [iOS Installation](https://firebase.flutter.dev/docs/installation/ios).

Run:

`flutter packages pub run build_runner watch`

## Initializing FlutterFire

https://firebase.flutter.dev/docs/overview/#initializing-flutterfire

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInitializer());
}

// ...

final Future<FirebaseApp> _initialization = initFirebase();

static Future<FirebaseApp> initFirebase() async {
  final firebaseInitialization = await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true);
  }
  return firebaseInitialization;
}
```

## Firebase Authentication

Initialize Auth in the console!

https://firebase.flutter.dev/docs/auth/overview/

https://firebase.flutter.dev/docs/auth/usage/

### login_page.dart

```dart
// TODO Implement Firebase user registration
try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  print("User registration successful! Logging in...");
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => PostsPage(),
    ),
  );
} on Exception catch (e) {
  print("User registration/login failed: ${e.toString()}");
}
```

```dart
// TODO Implement Firebase login
try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  print("Logging in...");
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => PostsPage(),
    ),
  );
} on Exception catch (e) {
  print("Login failed: ${e.toString()}");
}
```

### posts_page.dart

```dart
// TODO Register for Firebase user changes
userEventsSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
  if (user != null) {
    setState(() {
      loggedInUserEmail = user.email;
    });
  }
});
```

```dart
// TODO Sign out the user
return FirebaseAuth.instance.signOut();
```

```dart
// TODO Crash the app
FirebaseCrashlytics.instance.crash();
```



## Firebase Realtime Database

https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_database

https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_database/example

https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_database/example/lib/main.dart

**Initialize RDB in the console!**

**Set up the Firebase project**

- Start in test mode

### posts_page.dart

```dart
@override
void initState() {
    // TODO Register for Firebase user changes
    userEventsSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          loggedInUserEmail = user.email;
        });
      }
    });

    // TODO Register for Database changes
    final postsRef = FirebaseDatabase.instance.reference().child("posts");

    postsEventsSubsription = postsRef.onChildAdded.listen((event) {
      final value = Map<String, dynamic>.from(event.snapshot.value);
      final newPost = Post.fromJson(value);

      setState(() {
        posts.add(newPost);
      });
    });
}
```

### create_post_page.dart

```dart
Future<void> _submitPost(BuildContext context) async {
  // TODO Upload image to Cloud Storage
  String imageUrl;
  if (selectedImage != null) {
    final storageRef = FirebaseStorage.instance.ref();
    final imageName = UriData.fromString(
      "${Uuid().v4()}.jpg",
      encoding: Encoding.getByName("UTF-8"),
    );
    final newImageRef = storageRef.child("images/$imageName");
    newImageRef.putFile(selectedImage).onComplete.then((value) async {
      imageUrl = await newImageRef.getDownloadURL();
      return uploadPost(context, imageUrl);
    });
  } else {
    uploadPost(context);
  }
}

Future<void> uploadPost(BuildContext context, [String imageUrl]) {
  // TODO create a new post in the Realtime Database
  final postsRef = FirebaseDatabase.instance.reference().child("posts");
  final key = postsRef.push().key;
  final newPost = Post(
          uid: key,
          title: _postTitleController.text,
          body: _postBodyController.text,
          author: FirebaseAuth.instance.currentUser?.email ?? "Anonymous",
          imageUrl: imageUrl)
      .toJson();
  postsRef.child(key).set(newPost).whenComplete(() => Navigator.of(context).pop());
  Navigator.of(context).pop()
}
```



## Firebase Cloud Storage

Initialize CS in the console!

https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_storage

https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_storage/example/lib/main.dart

- only the upload part

## Image picking

https://pub.dev/packages/image_picker

## Crashlytics

https://pub.dev/packages/firebase_crashlytics

https://firebase.flutter.dev/docs/crashlytics/usage/

### main.dart

```dart
import 'package:flutter/foundation.dart' show kDebugMode;

// ...

if (kDebugMode) {
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(false); // Set to true for the demo
}

```



### posts_page.dart

```dart
FirebaseCrashlytics.instance.crash();
```



