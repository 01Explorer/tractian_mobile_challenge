import 'package:flutter/material.dart';

import '../../../../domain/entities/abstract_classes/item.dart';
import 'item_tile_component.dart';

class TreeComponent extends StatelessWidget {
  const TreeComponent({
    super.key,
    required this.itemToBuild,
  });

  final Item itemToBuild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ExpansionTile(
        leading: itemToBuild.itemChildren.isEmpty ? const SizedBox() : null,
        controlAffinity: ListTileControlAffinity.leading,
        title: ItemTileComponent(itemToBuild: itemToBuild),
        children: itemToBuild.itemChildren
            .map<Widget>((child) => TreeComponent(itemToBuild: child))
            .toList(),
      ),
    );
  }
}
