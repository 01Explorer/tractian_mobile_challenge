enum SensorType {
  energy,
  vibration;

  factory SensorType.fromString(String type) {
    return switch (type) {
      'energy' => SensorType.energy,
      _ => SensorType.vibration,
    };
  }
}

enum SensorStatus {
  alert,
  operating;

  factory SensorStatus.fromString(String status) {
    return switch (status) {
      'alert' => SensorStatus.alert,
      _ => SensorStatus.operating,
    };
  }
}

typedef Sensor = ({SensorType sensorType, SensorStatus sensorStatus});
