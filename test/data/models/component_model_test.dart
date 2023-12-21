import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/helpers/helper_types.dart';
import 'package:tractian_challenge/data/models/component_model.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';

void main() {
  const testJson = {
    'name': 'Component 1',
    'parentId': '28194712941890421jk',
    'status': 'operating',
    'sensorType': 'energy',
    'id': '1',
  };

  final componentModelTest = ComponentModel(
      name: 'Component 1',
      parentId: '28194712941890421jk',
      locationId: null,
      id: '1',
      sensor: (
        sensorStatus: SensorStatus.operating,
        sensorType: SensorType.energy
      ));

  final componentEntityTest = ComponentEntity(
      name: 'Component 1',
      parentId: '28194712941890421jk',
      locationId: null,
      id: '1',
      sensor: (
        sensorStatus: SensorStatus.operating,
        sensorType: SensorType.energy
      ));

  test('Creating a Component Model from a Json should return a valid structure',
      () {
    final result = ComponentModel.fromJson(testJson);
    expect(result, isA<ComponentModel>());
    expect(result, componentModelTest);
  });

  test(
      'Transforming a Component Model to a Location Entity should return a valid structure',
      () {
    final result = componentModelTest.toComponentEntity();
    expect(result, isA<ComponentEntity>());
    expect(result, componentEntityTest);
  });
}
