import 'package:tractian_challenge/core/helpers/helper_types.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';

class ComponentModel extends ComponentEntity {
  ComponentModel({
    required super.name,
    required super.parentId,
    required super.id,
    required super.sensor,
    required super.locationId,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      name: json['name'],
      parentId: json['parentId'],
      id: json['id'],
      sensor: (
        sensorStatus: SensorStatus.fromString(json['status']),
        sensorType: SensorType.fromString(json['sensorType']),
      ),
      locationId: json['locationId'],
    );
  }

  ComponentEntity toComponentEntity() {
    return ComponentEntity(
      name: name,
      parentId: parentId,
      id: id,
      sensor: sensor,
      locationId: locationId,
    );
  }
}
