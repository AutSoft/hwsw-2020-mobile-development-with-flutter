import 'package:flutter/material.dart';
import 'package:flutter_forum/ui/login/login_page.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Future<void> _logout() {
    // TODO log out the logged in Firebase user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterForum Posts"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Material(
              child: UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
              ),
            ),
            InkWell(
              onTap: () {
                _logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text("Logout"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(builder: (context, snapshot) {}),
    );
  }
}
