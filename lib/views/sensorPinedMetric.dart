import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../model/metricModel.dart';

class SensorPinnedMetric extends StatelessWidget {
  SensorPinnedMetric(this.metricModel);
  final MetricModel metricModel;

  @override
  Widget build(BuildContext context) {
    
    Row _buildMetricAsIcon(IconData icon, DateTime lastActivity) {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            // margin: const EdgeInsets.only(
            //   top: 8.0,
            //   bottom: 8.0,
            //   left: 0.0,
            // ),
            child: IconButton( icon: new Icon(icon,
                size: Theme.of(context).textTheme.subhead.fontSize),
                onPressed: (){},
                )
          ),
        ],
      );
    }

    FlatButton _buildMetricAsText(String label, String unit, DateTime lastActivity) {
      //Color color = Theme.of(context).primaryColor;
      double fontSize = Theme.of(context).textTheme.caption.fontSize;
      return  FlatButton(child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            // margin: const EdgeInsets.only(
            //   top: 8.0,
            //   bottom: 8.0,
            //   left: 0.0,
            // ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                // color: color,
              ),
            ),
          ),
          new Container(
            // margin: const EdgeInsets.only(
            //   top: 8.0,
            //   bottom: 8.0,
            //   right: 0.0,
            // ),
            child: Text(
              unit,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                // color: color,
              ),
            ),
          )
        ],
      ),
      onPressed: (){},
      );
    }

    
    if (metricModel.id == 'M')
      return _buildMetricAsIcon(MdiIcons.runFast, metricModel.updated);
    return _buildMetricAsText(
        metricModel.value.toString(), metricModel.unit, metricModel.updated);
  }
}
