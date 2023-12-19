import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';

abstract class Item extends Equatable {
  final String name;
  final String? parentId;
  final String? locationId;
  final String id;
  final List<Item> itemChildren = [];

  Item({
    required this.name,
    required this.parentId,
    required this.locationId,
    required this.id,
  });

  bool get isRoot => parentId == null && locationId == null;

  String? get parent {
    if (isRoot) {
      return null;
    }
    return parentId ?? locationId;
  }

  void addChildren(Item item) {
    if (this is ComponentEntity) {
      throw Exception('Components cannot have children');
    }
    itemChildren.add(item);
  }
}
