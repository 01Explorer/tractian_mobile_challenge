import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/repositories/company_repository_impl.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/asset_entity.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late final LocalDataSource mockLocalDataSource;
  late final CompanyRepository companyRepository;

  setUpAll(() {
    mockLocalDataSource = MockLocalDataSource();
    companyRepository = CompanyRepositoryImpl(mockLocalDataSource);
  });

  group('Fetch Companies', () {
    test(
        'If calling fetch companies is successful should return a list of CompanyEntity',
        () async {
      when(mockLocalDataSource.fetchCompanies(dirPath: sampleDataDir))
          .thenAnswer((_) async =>
              const Right(['Company 1', 'Company 2', 'Company 3']));

      final result = await companyRepository.fetchCompanies();
      result.fold((l) => expect(l, isNull),
          (r) => expect(r, isA<List<CompanyEntity>>()));
    });

    test('If calling fetch companies fails should', () async {
      when(mockLocalDataSource.fetchCompanies(dirPath: sampleDataDir))
          .thenThrow(const CompanyException(message: 'There are no companies'));

      final result = await companyRepository.fetchCompanies();
      result.fold(
          (l) => expect(l, isA<CompanyFailure>()), (r) => expect(r, isNull));
    });
  });

  group('Get Company Tree Components', () {
    final testCompanyEntity = CompanyEntity(name: 'test', rootComponents: []);
    final testSuccessResult = [
      {
        'name': 'Location',
        'type': 'location',
        'parentId': null,
        'id': '1',
      },
      {
        'name': 'Fan',
        'type': 'asset',
        'parentId': '1',
        'id': '2',
      },
      {
        'name': 'Sub Loc',
        'type': 'location',
        'parentId': '1',
        'id': '3',
      },
      {
        'name': 'Conveyor Belt',
        'type': 'asset',
        'parentId': null,
        'id': '4',
      },
      {
        'name': 'Rubber Belt',
        'type': 'component',
        'parentId': null,
        'status': 'operating',
        'sensorType': 'vibration',
        'id': '5',
      },
    ];
    test(
        'If calling Get Company Tree components is successful should then return a list of item',
        () async {
      when(
        mockLocalDataSource.getCompanyTreeComponents(
            dirPath: '$sampleDataDir/test'),
      ).thenAnswer((_) async => Right(testSuccessResult));

      final result = await companyRepository.getCompanyTreeComponents(
          companyEntity: testCompanyEntity);
      late final List<Item> resultList;
      result.fold((l) => expect(l, isNull), (r) {
        resultList = List.from(r);
        expect(r, isA<List<Item>>());
      });
      for (final item in resultList) {
        expect(
          item,
          anyOf(
            isA<LocationEntity>(),
            isA<AssetEntity>(),
            isA<ComponentEntity>(),
          ),
        );
      }
    });

    test(
        'If calling Get Company Tree components fails should then return a TreeFailure',
        () async {
      when(
        mockLocalDataSource.getCompanyTreeComponents(
            dirPath: '$sampleDataDir/test'),
      ).thenAnswer((_) async =>
          const Left(TreeFailure(message: 'There are no components')));

      final result = await companyRepository.getCompanyTreeComponents(
          companyEntity: testCompanyEntity);

      expect(
          result, const Left(TreeFailure(message: 'There are no components')));
    });
  });
}
