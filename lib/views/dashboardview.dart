import 'package:flutter/material.dart';
import './drawerhomenet.dart';

class DashboardView extends StatefulWidget {
  static String routeName = '/';
  @override
  DashboardViewState createState() => new DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
 Widget build(BuildContext context) {
        return Scaffold ( 
          appBar: new AppBar(
            title: new Text('Dashboard'),

          ),
          body: new Center(
            child: new Text("Dashboard View"),
            ),
          drawer: HomeNetDrawer(),
          );
 }
}