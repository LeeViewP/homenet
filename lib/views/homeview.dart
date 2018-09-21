import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './drawerhomenet.dart';
import 'package:flutter/rendering.dart';
import './dashboardview.dart';
import './sensorview.dart';
import './settingsview.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/';
  @override
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _currentIndex = 0;
  Widget dashboardView = new DashboardView();
  Widget sensorsView = new SensorView();
  Widget settingsView =  new SettingsView();
  
  BottomNavigationBarItem dashboardItem = new BottomNavigationBarItem(
            icon: new Icon(Icons.dashboard),
            title: new Text("Dashboard"),
          );
  BottomNavigationBarItem sensorsItem = new BottomNavigationBarItem(
            icon: new Icon(Icons.developer_board),
            title: new Text("Sensors"),
          );
  BottomNavigationBarItem settingsItem = new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text("Settings"),
          );


  final List<Widget> _navigationPages = new List<Widget>();
  final List<BottomNavigationBarItem> _navigationItems = new List<BottomNavigationBarItem>();

@override
  void initState() {
    super.initState();
    _navigationItems.add(dashboardItem);
    _navigationPages.add(dashboardView);

    _navigationItems.add(sensorsItem);
    _navigationPages.add(sensorsView);

    _navigationItems.add(settingsItem);
    _navigationPages.add(settingsView);
    _currentIndex=1;
}
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _navigationPages[_currentIndex],
      bottomNavigationBar: new  BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: onTabTapped,
        items: _navigationItems.toList(),
      ),
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}
