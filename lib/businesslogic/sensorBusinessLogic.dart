import '../model/metricModel.dart';
import '../model/sensorModel.dart';
import '../services/metricsService.dart';
import 'metricBussinesLogic.dart';

class SensorBusinessLogic {
  SensorModel sensorModel;
  List<MetricModel> _metricList;
  MetricsService _metricService = new MetricsService();

  SensorBusinessLogic({this.sensorModel}) {
    _metricService.addChangesListener(sensorModel.id, () {
      _metricService.getMetrics(sensorModel.id).then((metrics) {
        this._metricList = metrics;
      });
    });
  }

  String get id => sensorModel.id;
  String get description => sensorModel.descr;
  String get name => sensorModel.label;
  String get sensorType => sensorModel.type;
  DateTime get lastUpdated => sensorModel.updated;
  List<MetricBusinessLogic> get metrics =>this._metricList.map((MetricModel metric)=>new MetricBusinessLogic(model: metric));
  List<MetricBusinessLogic> get titledMetrics => this._metricList.where((metric)=>metric.id == 'V' || metric.id == "RSSI").map((MetricModel model)=> new MetricBusinessLogic( model: model));
  List<MetricBusinessLogic> get pinnedMetrics => this._metricList.where((metric)=>metric.pin==true).map((MetricModel model)=> new MetricBusinessLogic( model: model));
}
