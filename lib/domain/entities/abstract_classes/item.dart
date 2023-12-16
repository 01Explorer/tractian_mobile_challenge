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

  void addChildren(Item item) {
    if (item is ComponentEntity) {
      throw Exception('Components cannot have children');
    }
    itemChildren.add(item);
  }
}
