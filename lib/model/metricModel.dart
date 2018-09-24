class MetricModel {
  String id;
  String label;
  bool pin;
  bool graph;
  String value;
  String unit;
  DateTime updated;

  MetricModel({this.id, this.label, this.unit, this.value, this.graph, this.pin, this.updated});
  
}
