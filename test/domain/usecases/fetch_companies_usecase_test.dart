import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';
import 'package:tractian_challenge/domain/usecases/fetch_companies_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late final CompanyRepository mockCompanyRepository;
  late final FetchCompaniesUsecase fetchCompaniesUsecase;

  setUp(() {
    mockCompanyRepository = MockCompanyRepository();
    fetchCompaniesUsecase = FetchCompaniesUsecase(mockCompanyRepository);
  });

  final returnCompanyEntityList = [
    CompanyEntity(
      name: 'Company 1',
      rootComponents: [],
    ),
    CompanyEntity(
      name: 'Company 2',
      rootComponents: [],
    ),
    CompanyEntity(
      name: 'Company 3',
      rootComponents: [],
    ),
  ];

  test(
      'Calling fetch companies if successful should return a list of CompanyEntity',
      () async {
    when(mockCompanyRepository.fetchCompanies())
        .thenAnswer((_) async => Right(returnCompanyEntityList));

    final result = await fetchCompaniesUsecase();
    expect(result, Right(returnCompanyEntityList));
  });

  test('Calling fetch companies if fails should return a CompanyFailure',
      () async {
    when(mockCompanyRepository.fetchCompanies()).thenAnswer((_) async =>
        const Left(CompanyFailure(message: 'There are no companies to fetch')));

    final result = await fetchCompaniesUsecase();
    expect(result,
        const Left(CompanyFailure(message: 'There are no companies to fetch')));
  });
}
