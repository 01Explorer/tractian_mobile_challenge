import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final LocalDataSource _localDataSource;

  CompanyRepositoryImpl(this._localDataSource);
  @override
  Future<Either<Failure, List<CompanyEntity>>> fetchCompanies() async {
    try {
      final result =
          await _localDataSource.fetchCompanies(dirPath: sampleDataDir);
      final companiesList = result.fold(
        (l) => null,
        (r) => r,
      );
      return Right(companiesList!
          .map((e) => CompanyEntity(name: e, rootComponents: []))
          .toList());
    } catch (e) {
      return Left(CompanyFailure(message: e.toString()));
    }
  }
}
