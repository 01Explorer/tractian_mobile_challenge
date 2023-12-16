import '../../core/helpers/helper_types.dart';
import 'abstract_classes/item.dart';

class ComponentEntity extends Item {
  final Sensor sensor;
  ComponentEntity({
    required super.name,
    required super.parentId,
    required super.id,
    required this.sensor,
    required super.locationId,
  }) : assert(parentId == null || locationId == null);

  @override
  List<Object?> get props => [
        name,
        parentId,
        id,
        sensor,
        locationId,
      ];
}
