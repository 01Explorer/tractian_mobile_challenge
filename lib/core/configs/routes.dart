import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/presentation/companies/pages/landing_page.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_bloc.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_event.dart';

import '../../injection_container.dart';
import '../../presentation/tree_view/pages/tree_view_page.dart';

class AppRoutes {
  static Route onGeneratedRoutes(RouteSettings settings) {
    return switch (settings.name) {
      landingPageRoute => _materialRoute(const LandingPage()),
      treeViewPageRoute => _materialWithTreeViewBlocInjection(
          TreeView(company: settings.arguments as CompanyEntity),
          settings.arguments as CompanyEntity),
      _ => _materialRoute(const LandingPage())
    };
  }

  static Route<dynamic> _materialRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> _materialWithTreeViewBlocInjection(
      Widget page, CompanyEntity company) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<TreeViewBloc>.value(
              value: locator()..add(LoadTreeViewEvent(company: company)),
              child: page,
            ));
  }
}
