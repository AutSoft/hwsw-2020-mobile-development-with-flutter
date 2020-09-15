import 'package:flutter/material.dart';

enum TopLevelScreen { HOME, MESSAGES }

class NavigationWidgetsDemo extends StatefulWidget {
  @override
  _NavigationWidgetsDemoState createState() => _NavigationWidgetsDemoState();
}

class _NavigationWidgetsDemoState extends State<NavigationWidgetsDemo> {
  int _currentBottomNavIndex = 0;

  TopLevelScreen _currentNavDrawerSelection = TopLevelScreen.HOME;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  void _onNavDrawerItemSelected(TopLevelScreen screen) {
    setState(() {
      _currentNavDrawerSelection = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO Add an AppBar
      appBar: AppBar(
        title: Text("A Nice Fintech App"),
      ),
      // TODO Add a Drawer
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Text(
                  "Logo\nof a nice\nfintech app",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  _onNavDrawerItemSelected(TopLevelScreen.HOME);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Messages"),
                onTap: () {
                  _onNavDrawerItemSelected(TopLevelScreen.MESSAGES);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
      // TODO Add a BottomNavigationBar
      bottomNavigationBar: bottomNavBarIfNeeded(_currentNavDrawerSelection),
      // TODO Add the body based on the Drawer and the BottomNavigationBar selection
      body: buildBody(_currentNavDrawerSelection, _currentBottomNavIndex),
    );
  }

  Widget bottomNavBarIfNeeded(TopLevelScreen toplLevelScreen) {
    switch (toplLevelScreen) {
      case TopLevelScreen.HOME:
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account),
              title: Text('Accounts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Wealth'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              title: Text('Payments'),
            ),
          ],
          currentIndex: _currentBottomNavIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onBottomNavTap,
        );
      case TopLevelScreen.MESSAGES:
        return null;
    }
  }

  Widget buildBody(
    TopLevelScreen currentNavDrawerSelection,
    int currentBottomNavIndex,
  ) {
    switch (currentNavDrawerSelection) {
      case TopLevelScreen.HOME:
        return buildHomeScreen(currentBottomNavIndex);
      case TopLevelScreen.MESSAGES:
        return Center(
          child: Text("A list of messages"),
        );
    }
  }

  Widget buildHomeScreen(int currentBottomNavIndex) {
    switch (currentBottomNavIndex) {
      case 0:
        return Center(
          child: Text("Accounts"),
        );
      case 1:
        return Center(
          child: Text("Wealth"),
        );
      case 2:
        return Center(
          child: Text("Payments"),
        );
      default:
        throw ArgumentError("Invalid home screen state");
    }
  }
}
