import 'package:flutter/material.dart';

// import 'package:ehabitat/views/drawerhomenet.dart';
class SettingsView extends StatefulWidget {
  static String routeName = '/settingsView';
  @override
  SettingsViewState createState() => new SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(
        fontSize: theme.textTheme.title.fontSize, color: theme.primaryColor);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Settings',
          style: titleTextStyle,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: new Center(
          child: new LinearProgressIndicator(
        value: null,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      )),
      // drawer: HomeNetDrawer(),
    );
  }
}
