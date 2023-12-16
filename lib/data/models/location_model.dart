import 'package:tractian_challenge/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.name,
    required super.parentId,
    required super.id,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      parentId: json['parentId'],
      id: json['id'],
    );
  }

  LocationEntity toLocationEntity() {
    return LocationEntity(
      name: name,
      parentId: parentId,
      id: id,
    );
  }
}
