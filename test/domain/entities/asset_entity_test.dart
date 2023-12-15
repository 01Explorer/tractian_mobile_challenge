import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/asset_entity.dart';

void main() {
  final childAsset = AssetEntity(
    name: 'Fan',
    parentId: '656a07b3f2d4a1001e2144bf',
    locationId: null,
    id: '656a07c3f2d4a1001e2144c5',
  );

  final locationChildAsset = AssetEntity(
    name: 'Fan',
    parentId: null,
    locationId: '656a07b3f2d4a1001e2144bf',
    id: '656a07c3f2d4a1001e2144c5',
  );

  final rootAsset = AssetEntity(
    name: 'Fan',
    parentId: null,
    locationId: null,
    id: '656a07c3f2d4a1001e2144c5',
  );

  test('the created entities should be an AssetEntity and a Item', () {
    expect(childAsset, isA<AssetEntity>());
    expect(childAsset, isA<Item>());
    expect(locationChildAsset, isA<AssetEntity>());
    expect(locationChildAsset, isA<Item>());
    expect(rootAsset, isA<AssetEntity>());
    expect(rootAsset, isA<Item>());
  });

  test(
      'An asset\'s child asset should have a parentId not null and locationId null',
      () {
    expect(childAsset.parentId, isNotNull);
    expect(childAsset.locationId, isNull);
  });

  test(
      'A Location\'s child asset should have a parentId null and locationId not null',
      () {
    expect(locationChildAsset.parentId, isNull);
    expect(locationChildAsset.locationId, isNotNull);
  });

  test('A root asset should have both parentId null and locationId null', () {
    expect(rootAsset.parentId, isNull);
    expect(rootAsset.locationId, isNull);
  });

  test(
      'Creating an invalid asset, with locationId and parentId not null, should throw an assertionError',
      () {
    expect(
        () => AssetEntity(
            name: 'Fan',
            parentId: '656a07b3f2d4a1001e2144bf',
            locationId: '656a07b3f2d4a1001e2144bf',
            id: '656a07c3f2d4a1001e2144c5'),
        throwsAssertionError);
  });
}
