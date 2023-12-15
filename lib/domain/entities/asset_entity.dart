import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';

class AssetEntity extends Item {
  AssetEntity({
    required super.name,
    required super.parentId,
    required super.locationId,
    required super.id,
  }) : assert(locationId == null || parentId == null);
}
