import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forum/domain/model/post.dart';
import 'package:flutter_forum/ui/createpost/create_post_page.dart';
import 'package:flutter_forum/ui/login/login_page.dart';
import 'package:flutter_forum/ui/posts/post_item.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  String loggedInUserEmail = "test@example.com";
  StreamSubscription userEventsSubscription;
  StreamSubscription postsEventsSubsription;
  Future<DataSnapshot> _postsSnapshot;

  List<Post> posts = [];

  @override
  void initState() {
    // TODO Register for Firebase user changes

    // TODO Register for Database changes
  }

  Future<void> _logOut() {
    // TODO Sign out the user
  }

  void _apocalypse() async {
    // TODO Crash the app

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterForum Posts"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(posts[index]);
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Material(
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  loggedInUserEmail.substring(0, loggedInUserEmail.indexOf("@")),
                ),
                accountEmail: Text(loggedInUserEmail),
              ),
            ),
            DrawerMenuItem(
              icon: Icon(Icons.exit_to_app),
              text: Text("Logout"),
              onTap: () {
                _logOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            DrawerMenuItem(
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              text: Text("Crash the app :("),
              onTap: () {
                _apocalypse();
              },
            ),
          ],
        ),
      ),
      // body: FutureBuilder(builder: (context, snapshot) {}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.forum),
      ),
    );
  }

  @override
  void dispose() {
    if (userEventsSubscription != null) userEventsSubscription.cancel();
    if (postsEventsSubsription != null) postsEventsSubsription.cancel();
    super.dispose();
  }
}

class DrawerMenuItem extends StatelessWidget {
  final Icon icon;
  final Text text;
  final Function() onTap;

  DrawerMenuItem({this.icon, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: icon,
            ),
            text,
          ],
        ),
      ),
    );
  }
}
