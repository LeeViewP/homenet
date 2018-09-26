import '../model/sensorModel.dart';
import 'sensorBusinessLogic.dart';
import '../services/sensorsService.dart';

class SensorsBusinessLogic{
  // SensorBusinessLogic logic = new SensorBusinessLogic(sensorModel: new SensorModel());
  SensorService _service = new SensorService();
  List<SensorModel> _sensors = new List<SensorModel>();
  SensorsBusinessLogic(){
    _service.addChangesListener((snap)=> update());
  }
  void update() {
    _service.getAllSensors().then((sensors) {

        this._sensors = sensors;
    });
  }
  

  List<SensorBusinessLogic> get sensors => this._sensors.map((SensorModel model)=>new SensorBusinessLogic(sensorModel: model)).toList();
}