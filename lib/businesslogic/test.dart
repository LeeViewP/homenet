import 'package:homenet/model/sensorModel.dart';

import 'metricBussinesLogic.dart';
import 'sensorBusinessLogic.dart';
class test{
  SensorBusinessLogic logic = new SensorBusinessLogic(sensorModel: new SensorModel());
  test(){
    logic.Metrics.where(test)
  }
}