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

  String get Id => sensorModel.id;
  String get Description => sensorModel.descr;
  String get Name => sensorModel.label;
  String get SensorType => sensorModel.type;
  DateTime get LastUpdated => sensorModel.updated;
  List<MetricBusinessLogic> get metrics =>this._metricList.map((MetricModel metric)=>new MetricBusinessLogic(model: metric));
  List<MetricBusinessLogic> get titledMetrics => this._metricList.where((metric)=>metric.id == 'V' || metric.id == "RSSI").map((MetricModel model)=> new MetricBusinessLogic( model: model));
  List<MetricBusinessLogic> get pinnedMetrics => this._metricList.where((metric)=>metric.pin==true).map((MetricModel model)=> new MetricBusinessLogic( model: model));
}
