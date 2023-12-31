import 'package:flutter/material.dart';

import '../../../../core/helpers/constansts.dart';
import '../../../../domain/entities/company_entity.dart';

class CompanyListTileComponent extends StatelessWidget {
  const CompanyListTileComponent({
    super.key,
    required this.company,
  });

  final CompanyEntity company;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          treeViewPageRoute,
          arguments: company,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(height: 100),
          child: Stack(
            children: [
              Card(
                elevation: 16,
                color: companiesColors,
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Image.asset(companyIcon),
                    title: Text(
                      company.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      tractianLog,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
