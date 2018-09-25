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
  String get Type => sensorModel.type;
  DateTime get LastUpdated => sensorModel.updated;
  List<MetricBusinessLogic> get Metrics =>
      this._metricList.map((MetricModel metric) {
        return new MetricBusinessLogic(model: metric);
      });
}
