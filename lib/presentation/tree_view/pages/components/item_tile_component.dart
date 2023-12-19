import 'package:flutter/material.dart';

import '../../../../core/helpers/constansts.dart';
import '../../../../core/helpers/helper_types.dart';
import '../../../../domain/entities/abstract_classes/item.dart';
import '../../../../domain/entities/asset_entity.dart';
import '../../../../domain/entities/company_entity.dart';
import '../../../../domain/entities/component_entity.dart';

class ItemTileComponent extends StatelessWidget {
  final Item itemToBuild;

  const ItemTileComponent({super.key, required this.itemToBuild});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(_getAssetPathBasedOnItemType(itemToBuild)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            itemToBuild.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        if (itemToBuild is ComponentEntity) ...[
          const SizedBox(width: 4),
          switch ((itemToBuild as ComponentEntity).sensor.sensorStatus) {
            SensorStatus.alert =>
              const Icon(Icons.circle, color: Colors.red, size: 16),
            _ => const Icon(Icons.bolt_rounded, color: Colors.green),
          }
        ]
      ],
    );
  }

  String _getAssetPathBasedOnItemType(Item item) {
    return switch (item) {
      (CompanyEntity _) => companyIcon,
      (ComponentEntity _) => componentIcon,
      (AssetEntity _) => assetIcon,
      _ => locationIcon,
    };
  }
}
