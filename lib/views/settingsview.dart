import 'package:flutter/material.dart';
// import 'package:ehabitat/views/drawerhomenet.dart';
class SettingsView extends StatefulWidget {
  static String routeName = '/settingsView';
  @override
  SettingsViewState createState() => new SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
 Widget build(BuildContext context) {
          return Scaffold ( 
          appBar: new AppBar(
            title: new Text('Settings'),

          ),
          body: new Center(
            child: new Text("Settings View"),
            ),
          // drawer: HomeNetDrawer(),
          );
 }
}