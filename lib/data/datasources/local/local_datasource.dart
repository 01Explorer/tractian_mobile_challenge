import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';

abstract class LocalDataSource {
  Future<Either<Failure, List<String>>> fetchCompanies(
      {required String dirPath});
  Future<Either<Failure, List<Map<String, dynamic>>>> getCompanyTreeComponents(
      {required String dirPath});
}
