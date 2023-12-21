import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_bloc.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_event.dart';
import 'package:tractian_challenge/presentation/companies/bloc/company_state.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart'
    as failures;

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockFetchCompaniesUsecase mockFetchCompaniesUsecase;
  late CompanyBloc companyBloc;

  setUp(() {
    mockFetchCompaniesUsecase = MockFetchCompaniesUsecase();
    companyBloc = CompanyBloc(mockFetchCompaniesUsecase);
  });

  final companiesTest = <CompanyEntity>[
    CompanyEntity(name: 'Company1', rootComponents: []),
    CompanyEntity(name: 'Company2', rootComponents: []),
    CompanyEntity(name: 'Company3', rootComponents: []),
    CompanyEntity(name: 'Company4', rootComponents: []),
  ];

  test('Initial state should be CompanyInitial', () {
    expect(companyBloc.state, isA<CompanyInitial>());
  });

  group('LoadCompaniesEvent', () {
    blocTest<CompanyBloc, CompanyState>(
      'Should emit companyLoading and then CompanyLoaded when gets Data',
      build: () {
        when(mockFetchCompaniesUsecase())
            .thenAnswer((_) async => Right(companiesTest));
        return companyBloc;
      },
      act: (bloc) => bloc.add(LoadCompaniesEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <CompanyState>[
        CompanyLoading(),
        CompanyLoaded(companies: companiesTest)
      ],
    );

    blocTest<CompanyBloc, CompanyState>(
      'Should emit companyLoading and then CompanyFailure when fails to get Data',
      build: () {
        when(mockFetchCompaniesUsecase()).thenAnswer((_) async =>
            const Left(failures.CompanyFailure(message: 'No Data Found')));
        return companyBloc;
      },
      act: (bloc) => bloc.add(LoadCompaniesEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <CompanyState>[
        CompanyLoading(),
        const CompanyFailure(message: 'No Data Found')
      ],
    );
  });
}
