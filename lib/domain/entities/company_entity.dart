import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';

class CompanyEntity {
  final String name;
  final List<Item> rootComponents;

  CompanyEntity({
    required this.name,
    required this.rootComponents,
  });
}
