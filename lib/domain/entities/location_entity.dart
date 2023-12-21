import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';

class LocationEntity extends Item {
  LocationEntity({
    required super.name,
    required super.parentId,
    required super.id,
  }) : super(locationId: null);

  @override
  List<Object?> get props => [
        name,
        parentId,
        id,
      ];
}
