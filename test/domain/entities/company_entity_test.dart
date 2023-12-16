import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/helpers/helper_types.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/asset_entity.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';

void main() {
  final companyTest = CompanyEntity(
    name: 'Test Company',
    rootComponents: [
      AssetEntity(
        id: '912849012cdsjkhfa',
        name: 'Test Asset',
        parentId: null,
        locationId: 'kfjhafkjashf1111',
      ),
      ComponentEntity(
        id: '912849012cdsjkhfa',
        name: 'Test Asset',
        parentId: null,
        locationId: 'kfjhafkjashf1111',
        sensor: (
          sensorStatus: SensorStatus.alert,
          sensorType: SensorType.vibration
        ),
      ),
      LocationEntity(
        id: 'kfjhafkjashf1111',
        name: 'Test Asset',
        parentId: null,
      ),
    ],
  );

  test(
      'A companyEntity should have a name String and a Map of tree components indexed by their ID',
      () {
    expect(companyTest, isA<CompanyEntity>());
    expect(companyTest.name, isA<String>());
    expect(companyTest.rootComponents, isA<List<Item>>());
  });
}
