import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';

abstract class LocalDataSource {
  Future<Either<Failure, List<String>>> fetchCompanies();
}
