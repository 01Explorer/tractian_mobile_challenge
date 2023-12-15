enum SensorType {
  energy,
  vibration,
}

enum SensorStatus {
  alert,
  operating,
}

typedef Sensor = ({SensorType sensorType, SensorStatus sensorStatus});
