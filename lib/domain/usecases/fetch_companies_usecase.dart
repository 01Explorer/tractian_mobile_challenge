import 'package:dartz/dartz.dart';

import '../../domain/entities/company_entity.dart';
import '../../core/exceptions/failure_exception.dart';
import '../repositories/company_repository.dart';

class FetchCompaniesUsecase {
  final CompanyRepository _companyRepository;

  FetchCompaniesUsecase(this._companyRepository);

  Future<Either<Failure, List<CompanyEntity>>> call() async {
    return await _companyRepository.fetchCompanies();
  }
}
