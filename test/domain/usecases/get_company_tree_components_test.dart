import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/helper_types.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/asset_entity.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';
import 'package:tractian_challenge/domain/usecases/get_company_tree_components_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late final CompanyRepository mockCompanyRepository;
  late final GetCompanyTreeComponentsUseCase getCompanyTreeComponentsUseCase;

  setUpAll(() {
    mockCompanyRepository = MockCompanyRepository();
    getCompanyTreeComponentsUseCase =
        GetCompanyTreeComponentsUseCase(mockCompanyRepository);
  });

  final rootItems = [
    LocationEntity(name: 'Location 1', parentId: null, id: '2173894719841ajja'),
    LocationEntity(name: 'Location 2', parentId: null, id: '2173894719841ajja'),
    AssetEntity(
        name: 'Asset 1',
        parentId: null,
        locationId: null,
        id: '472189471289jjj'),
    ComponentEntity(
        name: 'Component 1',
        parentId: null,
        id: '1894712987419aa',
        sensor: (
          sensorStatus: SensorStatus.alert,
          sensorType: SensorType.energy
        ),
        locationId: null),
  ];

  final company = CompanyEntity(name: 'Company', rootComponents: []);

  test(
      'If getting the tree components is successful should return a list of items with only the root ones',
      () async {
    when(
      mockCompanyRepository.getCompanyTreeComponents(companyEntity: company),
    ).thenAnswer((_) async => Right(rootItems));

    final result =
        await getCompanyTreeComponentsUseCase(companyEntity: company);
    expect(result, Right(rootItems));

    result.fold((l) => expect(l, isNull), (r) {
      expect(r, isA<List<Item>>());

      for (final item in rootItems) {
        if (item is LocationEntity) {
          expect(item.parentId, isNull);
        }
        if (item is AssetEntity || item is ComponentEntity) {
          expect(item.parentId, isNull);
          expect(item.locationId, isNull);
        }
      }
    });
  });

  test('If getting the tree components fails then should return a TreeFailure',
      () async {
    when(
      mockCompanyRepository.getCompanyTreeComponents(companyEntity: company),
    ).thenAnswer((_) async =>
        const Left(TreeFailure(message: 'Failed to get components')));

    final result =
        await getCompanyTreeComponentsUseCase(companyEntity: company);

    expect(
        result, const Left(TreeFailure(message: 'Failed to get components')));
  });
}
