import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource_impl.dart';
import 'package:tractian_challenge/data/repositories/company_repository_impl.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';
import 'package:tractian_challenge/domain/usecases/fetch_companies_usecase.dart';
import 'package:tractian_challenge/domain/usecases/get_company_tree_components_usecase.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_bloc.dart';
import 'package:tractian_challenge/presentation/tree_view/pages/bloc/tree_view_bloc.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<LocalDataSource>(LocalDataSourceImpl());
  locator
      .registerSingleton<CompanyRepository>(CompanyRepositoryImpl(locator()));
  locator.registerSingleton<FetchCompaniesUsecase>(
      FetchCompaniesUsecase(locator()));
  locator.registerSingleton<GetCompanyTreeComponentsUseCase>(
      GetCompanyTreeComponentsUseCase(locator()));
  locator.registerFactory<CompanyBloc>(() => CompanyBloc(locator()));
  locator.registerFactory<TreeViewBloc>(() => TreeViewBloc(locator()));
}
