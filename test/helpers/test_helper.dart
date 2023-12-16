import 'package:mockito/annotations.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

@GenerateMocks([
  CompanyRepository,
  LocalDataSource,
])
void main() {}
