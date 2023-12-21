import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/data/models/location_model.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';

void main() {
  const testJson = {
    'name': 'Location',
    'parentId': null,
    'id': '1',
  };

  final locationModelTest =
      LocationModel(name: 'Location', parentId: null, id: '1');

  final locationEntityTest = LocationEntity(
    name: 'Location',
    parentId: null,
    id: '1',
  );

  test('Creating a Location Model from a Json should return a valid structure',
      () {
    final result = LocationModel.fromJson(testJson);
    expect(result, isA<LocationModel>());
    expect(result, locationModelTest);
  });

  test(
      'Transforming a Location Model to a Location Entity should return a valid structure',
      () {
    final result = locationModelTest.toLocationEntity();
    expect(result, isA<LocationEntity>());
    expect(result, locationEntityTest);
  });
}
