import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/core/helpers/extensions.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_bloc.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_state.dart';

import '../../../../core/helpers/constansts.dart';
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
          ).boldSubString(
              (context.read<TreeViewBloc>().state as TreeViewLoaded).filter),
        ),
        if (itemToBuild is ComponentEntity) ...[
          const SizedBox(width: 4),
          if (itemToBuild.isEletricSensor) ...[
            const Icon(Icons.bolt_rounded, color: Colors.green),
            const SizedBox(width: 4),
          ],
          if (itemToBuild.isCritical) ...[
            const Icon(Icons.circle, color: Colors.red, size: 16),
          ],
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
