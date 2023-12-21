import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/core/configs/routes.dart';
import 'package:tractian_challenge/core/configs/theme.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/injection_container.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_bloc.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_event.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyBloc>.value(
          value: locator()..add(LoadCompaniesEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGeneratedRoutes,
        theme: appTheme(),
        initialRoute: landingPageRoute,
      ),
    );
  }
}
