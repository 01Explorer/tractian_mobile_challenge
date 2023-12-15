import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';

void main() {
  final rootLocation = LocationEntity(
    name: 'SOMEWHERE',
    parentId: null,
    id: '656a07b3f2d4a1001e2144bf',
  );

  final subLocation = LocationEntity(
    name: 'OTHER PLACE IN SOMEWHERE',
    parentId: '656a07b3f2d4a1001e2144bf',
    id: '656a07bbf2d4a1001e2144c2',
  );

  test('The created entities should be a LocationEntity', () {
    expect(rootLocation, isA<LocationEntity>());
    expect(subLocation, isA<LocationEntity>());
  });

  test('A root locationEntity should have parentId == null', () {
    expect(rootLocation.parentId, isNull);
  });

  test('A sublocation locationEntity should have parentId != null', () {
    expect(subLocation.parentId, isNotNull);
  });
}
