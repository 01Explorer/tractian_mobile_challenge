import 'package:mockito/annotations.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';
import 'package:tractian_challenge/domain/usecases/fetch_companies_usecase.dart';
import 'package:tractian_challenge/domain/usecases/get_company_tree_components_usecase.dart';

@GenerateMocks([
  CompanyRepository,
  LocalDataSource,
  GetCompanyTreeComponentsUseCase,
  FetchCompaniesUsecase,
])
void main() {}
