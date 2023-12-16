import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';

import '../entities/abstract_classes/item.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> fetchCompanies();
  Future<Either<Failure, List<Item>>> getCompanyTreeComponents(
      {required CompanyEntity companyEntity});
}
