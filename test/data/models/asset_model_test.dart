import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/data/models/asset_model.dart';
import 'package:tractian_challenge/domain/entities/asset_entity.dart';

void main() {
  const testJson = {
    'name': 'Asset 1',
    'status': 'operating',
    'locationId': '178491284871241aaaa',
    'sensorType': 'energy',
    'id': '1',
  };

  final assetModelTest = AssetModel(
    name: 'Asset 1',
    locationId: '178491284871241aaaa',
    parentId: null,
    id: '1',
  );

  final assetEntityTest = AssetEntity(
    name: 'Asset 1',
    locationId: '178491284871241aaaa',
    parentId: null,
    id: '1',
  );

  test('Creating an Asset Model from a Json should return a valid structure',
      () {
    final result = AssetModel.fromJson(testJson);
    expect(result, isA<AssetModel>());
    expect(result, assetModelTest);
  });

  test(
      'Transforming an Asset Model to a Location Entity should return a valid structure',
      () {
    final result = assetModelTest.toAssetEntity();
    expect(result, isA<AssetEntity>());
    expect(result, assetEntityTest);
  });
}
