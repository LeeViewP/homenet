import 'package:flutter/material.dart';
import './drawerhomenet.dart';
import 'package:flutter/rendering.dart';

class DashboardView extends StatefulWidget {
  static String routeName = '/dashboarview';
  @override
  DashboardViewState createState() => new DashboardViewState();
}

class DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  final List<Tab> graphTabList = <Tab>[
    Tab(text: "DAY"),
    Tab(text: "WEEK"),
    Tab(text: "MONTH"),
    Tab(text: "YEAR"),
  ];
  Widget build(BuildContext context) {
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Row buildTitleRow(IconData icon, String title) {
      Color color = Theme.of(context).accentColor;
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Icon(icon, color: color),
          new Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ],
      );
    }

    Widget securityButtonSection = new Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.lock, 'ARM'),
          buildButtonColumn(Icons.lock_open, 'DISARM'),
          // buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget securityTitleSection = new Container(
        padding: const EdgeInsets.all(16.0),
        child: buildTitleRow(Icons.security, "Security"));
    Widget thermostatTitleSection = new Container(
        padding: const EdgeInsets.all(16.0),
        child: buildTitleRow(Icons.home, "Indoor environment"));

    Widget thermostatButtonSection = new Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.whatshot, 'HEAT'),
          buildButtonColumn(Icons.ac_unit, 'COLD'),
          // buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget outsideTitleSection = new Container(
        padding: const EdgeInsets.all(16.0),
        child: buildTitleRow(Icons.cloud_queue, "Outside environment"));

    TabController _controller =
        new TabController(length: 4, vsync: this, initialIndex: 0);
    Widget graphTabs = new Container(
      child: new TabBar(
        labelColor: Theme.of(context).primaryColor,
        controller: _controller,
        tabs: graphTabList,
      ),
    );
    Widget graphsContent = new Flexible(
      child: new TabBarView(
        controller: _controller,
        // children: graphTabList.map((Tab tab){
        //   return new Center(child: new Text(tab.text));
        // }).toList()
        children: [
          new Container(child: new Icon(Icons.ac_unit)),
          new Container(child: new Icon(Icons.ac_unit)),
          new Container(child: new Icon(Icons.ac_unit)),
          new Container(child: new Icon(Icons.ac_unit)),
        ],
      ),
    );

    Widget graphs = new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[graphTabs, graphsContent],
    );

    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(fontSize: theme.textTheme.title.fontSize, color:theme.primaryColor );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dashboard', style: titleTextStyle,),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData( color: theme.primaryColor),
      ),
      body: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[securityTitleSection, securityButtonSection],
            ),
          ),
          new Card(
            child: new Column(
              children: <Widget>[
                thermostatTitleSection,
                thermostatButtonSection
              ],
            ),
          ),
          new Card(
              child: new Column(
            children: <Widget>[outsideTitleSection, graphTabs],
          )),
        ],
      ),
      // drawer: HomeNetDrawer(),
    );
  }
}
