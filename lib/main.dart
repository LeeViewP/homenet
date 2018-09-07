import 'package:flutter/material.dart';
import './views/app.dart';

void main() => runApp(new HomeNet());
// import 'package:ehabitat/randomwords/randomwords.dart';
// import "package:ehabitat/MyHomePage/MyHomePage.dart";

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'homeNet.ai',
//       theme: new ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//         // counter didn't reset back to zero; the application is not restarted.
//         // brightness: Brightness.dark,
//         primarySwatch: Colors.green,
//         accentColor: Colors.redAccent,
//       ),
//       //home: new MyHomePage(title: 'eHabitat Home Page'),
//       home: new Scaffold(
//         appBar: AppBar(
//           title: Text("Random words page"),
//         ),
//         body: RandomWords(),
//         drawer: new Drawer(
//             child: new ListView(padding: EdgeInsets.zero, children: <Widget>[
//           new UserAccountsDrawerHeader(

//             accountName: Text("Liviu Perecrestov"),
//             accountEmail: Text("liviu.perecrestov@gmail.com"),
//           ),
//           new ListTile(
//             leading: new Icon(Icons.dashboard),
//             title: new Text("Dashboard"),
//             onTap: () {
//               Navigator.push(context, new MaterialPageRoute(builder: (context) { return new MyHomePage();}));
//               //Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.developer_board),
//             title: Text("Sensors"),
//             onTap: () {
//              Navigator.push(context, new MaterialPageRoute(builder: (context) => new RandomWords()));
//             },
//           ),
//         Divider(),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("Settings"),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ])),
//       ),
//     );
//   }
// }
