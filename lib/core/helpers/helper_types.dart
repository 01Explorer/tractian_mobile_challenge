enum SensorType {
  energy,
  vibration,
  smartTracker;

  factory SensorType.fromString(String type) {
    return switch (type) {
      'energy' => SensorType.energy,
      'vibration' => SensorType.vibration,
      _ => SensorType.smartTracker,
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
