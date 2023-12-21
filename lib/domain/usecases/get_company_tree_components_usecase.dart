import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

import '../../core/exceptions/failure_exception.dart';
import '../entities/abstract_classes/item.dart';

class GetCompanyTreeComponentsUseCase {
  final CompanyRepository _companyRepository;

  GetCompanyTreeComponentsUseCase(this._companyRepository);

  Future<Either<Failure, List<Item>>> call(
      {required CompanyEntity companyEntity}) async {
    return await _companyRepository.getCompanyTreeComponents(
        companyEntity: companyEntity);
  }
}
