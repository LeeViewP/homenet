import 'package:flutter/material.dart';
import './dashboardview.dart';
import './sensorview.dart';
import './settingsview.dart';


class HomeNetDrawer extends StatefulWidget{
  static const String routeName = 'material/drawer';
  @override
  HomeNetDrawerState createState() => new HomeNetDrawerState();
}

class HomeNetDrawerState extends State<HomeNetDrawer> 
{
  Widget build(BuildContext context) {
        return new Drawer(
            child: new ListView(
              padding: EdgeInsets.zero, 
              children: <Widget>[
                  new UserAccountsDrawerHeader(

                    accountName: Text("Liviu Perecrestov"),
                    accountEmail: Text("liviu.perecrestov@gmail.com"),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.dashboard),
                    title: new Text("Dashboard"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(DashboardView.routeName);
                      // Navigator.of(context).pushNamed(DashboardView.routeName);
                    },
                    
                  ),
                  new ListTile(
                    leading: Icon(Icons.developer_board),
                    title: Text("Sensors"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SensorView.routeName);
                    },
                  ),
                  new Divider(),
                  new ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SettingsView.routeName);
                      },
                    ),
          ])
          );
 }
}
// class HomeNetDrawerState extends State<HomeNetDrawer>  with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   AnimationController _controller;
//   Animation<double> _drawerContentsOpacity;
//   Animation<Offset> _drawerDetailsPosition;
//   bool _showDrawerContents = true;

//  @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _drawerContentsOpacity = new CurvedAnimation(
//       parent: new ReverseAnimation(_controller),
//       curve: Curves.fastOutSlowIn,
//     );
//     _drawerDetailsPosition = new Tween<Offset>(
//       begin: const Offset(0.0, -1.0),
//       end: Offset.zero,
//     ).animate(new CurvedAnimation(
//       parent: _controller,
//       curve: Curves.fastOutSlowIn,
//     ));
//   }
//     @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }