abstract class Item {
  final String name;
  final String? parentId;
  final String? locationId;
  final String id;

  Item({
    required this.name,
    required this.parentId,
    required this.locationId,
    required this.id,
  });
}
