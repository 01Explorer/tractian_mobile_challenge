import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/presentation/companies/pages/landing_page.dart';

import '../../presentation/tree_view/pages/tree_view_page.dart';

class AppRoutes {
  static Route onGeneratedRoutes(RouteSettings settings) {
    return switch (settings.name) {
      landingPageRoute => _materialRoute(const LandingPage()),
      treeViewPageRoute =>
        _materialRoute(TreeView(company: settings.arguments as CompanyEntity)),
      _ => _materialRoute(const LandingPage())
    };
  }

  static Route<dynamic> _materialRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
