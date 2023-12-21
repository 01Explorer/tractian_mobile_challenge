import 'package:tractian_challenge/domain/entities/asset_entity.dart';

class AssetModel extends AssetEntity {
  AssetModel({
    required super.name,
    required super.parentId,
    required super.locationId,
    required super.id,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      name: json['name'],
      parentId: json['parentId'],
      locationId: json['locationId'],
      id: json['id'],
    );
  }

  AssetEntity toAssetEntity() {
    return AssetEntity(
      name: name,
      parentId: parentId,
      locationId: locationId,
      id: id,
    );
  }
}
