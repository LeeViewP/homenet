import 'package:flutter/material.dart';
import '../views/sensorView.dart';
import './sensorPinedMetric.dart';
import './sensorTitleMetric.dart';
import '../model/sensorModel.dart';
import '../model/metricModel.dart';
import '../services/metricsService.dart';

class SensorCard extends StatefulWidget {
  final SensorModel sensor;
  SensorCard(this.sensor);
  @override
  SensorCardState createState() => new SensorCardState();
}

class SensorCardState extends State<SensorCard> {
  MetricsService service = new MetricsService();
  List<MetricModel> metrics;
  // bool isLoading;
  @override
  void initState() {
    super.initState();
    // isLoading = true;
    service.addChangesListener(widget.sensor.id, (snapshot) {
      updateMetrics();
    });
  }

  void updateMetrics() {
    service.getMetrics(widget.sensor.id).then((metrics) {
      setState(() {
        // isLoading=false;
        this.metrics = metrics;
      });
    });
  }

  void _handleTap() {
    setState(() {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new SensorView(widget.sensor)));
       Navigator.of(context).pushNamed(SensorView.routeName);
    });
  }

  Widget build(BuildContext context) {

   // metrics.where((item)=>item.pin == true).map((MetricModel model){return new SensorTitleMetric(model);} );
    //metrics.where((item)=>item.id == 'RSSI').where((item)=>item.id == 'V').map((MetricModel model){return new SensorPinnedMetric(model);} );
    if (this.metrics!=null){
    var titleMetrics = metrics.where((item)=>item.id == 'RSSI' || item.id == 'V').map((MetricModel model){return new SensorTitleMetric(model);});
    var pinnedMetrics =metrics.where((item)=>item.pin == true).map((MetricModel model){return new SensorPinnedMetric(model);});
    Row _buildTitle(String label, String descr, IconData icon) {

      var textPadding = const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0);
      var metricTitlePadding =
          const EdgeInsets.only(right: 8.0, top: 2.0, bottom: 2.0);
      var imagePadding =
          const EdgeInsets.only(right: 16.0, top: 2.0, bottom: 2.0);
      return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 8.0,
                ),
                child: new Icon(null,
                    size: Theme.of(context).textTheme.subhead.fontSize),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                padding: textPadding,
                child: new Text(label,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                padding: textPadding,
                child: new Text(descr,
                    style: new TextStyle(
                      color: Theme.of(context).disabledColor,
                    ),
                    textAlign: TextAlign.left),
              ),
            ],
          ),
          new Expanded(
            child: new Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.centerRight,
                    padding: metricTitlePadding,
                    child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:
                            titleMetrics.toList(),
                                        )                    ,
                  ),
                  //ITEM PICTURE
                  new Container(
                    alignment: Alignment.centerRight,
                    padding: imagePadding,
                    child: new Icon(
                      icon,
                      size: Theme.of(context).textTheme.display1.fontSize,
                    ),
                  ),
                  // ),
                ]),
          )
        ],
      );
    }
    var sensor = widget.sensor;
    return new GestureDetector(
        onTap: _handleTap,
        child: new Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTitle(sensor.label, sensor.descr, Icons.desktop_mac),
                new Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child:    new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            pinnedMetrics.toList(),
                                        ),
                ),
              ],
            )));
    }
    return new Card();
  }
}
