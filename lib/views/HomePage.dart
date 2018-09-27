import 'package:flutter/material.dart';
import './dashboardview.dart';
import './sensorsView.dart';
import './settingsview.dart';
import './HomePageView.dart';

// import './sensorsModelsView.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  @override
  HomePageView createState() => new HomePageView();
}

abstract class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @protected
  int currentIndex = 0;
  @protected
  final List<Widget> navigationPages = new List<Widget>();
  @protected
  final List<BottomNavigationBarItem> navigationItems = new List<BottomNavigationBarItem>();

  Widget dashboardView = new DashboardView();
  Widget sensorsView = new SensorsView();
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


@override
  void initState() {
    super.initState();
    navigationItems.add(dashboardItem);
    navigationPages.add(dashboardView);

    navigationItems.add(sensorsItem);
    navigationPages.add(sensorsView);

    navigationItems.add(settingsItem);
    navigationPages.add(settingsView);

    currentIndex=1;
}
  
  void onTabTapped(int index) {
   setState(() {
     currentIndex = index;
   });
 }
}
