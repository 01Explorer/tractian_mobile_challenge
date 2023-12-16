import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/repositories/company_repository_impl.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late final LocalDataSource mockLocalDataSource;
  late final CompanyRepository companyRepository;

  setUpAll(() {
    mockLocalDataSource = MockLocalDataSource();
    companyRepository = CompanyRepositoryImpl(mockLocalDataSource);
  });

  test(
      'If calling fetch companies is successful should return a list of CompanyEntity',
      () async {
    when(mockLocalDataSource.fetchCompanies(dirPath: sampleDataDir)).thenAnswer(
        (_) async => const Right(['Company 1', 'Company 2', 'Company 3']));

    final result = await companyRepository.fetchCompanies();
    result.fold(
        (l) => expect(l, isNull), (r) => expect(r, isA<List<CompanyEntity>>()));
  });

  test('If calling fetch companies fails should', () async {
    when(mockLocalDataSource.fetchCompanies(dirPath: sampleDataDir))
        .thenThrow(const CompanyException(message: 'There are no companies'));

    final result = await companyRepository.fetchCompanies();
    result.fold(
        (l) => expect(l, isA<CompanyFailure>()), (r) => expect(r, isNull));
  });
}
