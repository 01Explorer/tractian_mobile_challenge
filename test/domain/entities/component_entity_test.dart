import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/enums/helper_types.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/component_entity.dart';

void main() {
  final childComponent = ComponentEntity(
    name: 'Fan',
    parentId: '656a07b3f2d4a1001e2144bf',
    locationId: null,
    id: '656a07c3f2d4a1001e2144c5',
    sensor: (
      sensorType: SensorType.energy,
      sensorStatus: SensorStatus.alert,
    ),
  );

  final locationChildComponent = ComponentEntity(
    name: 'Fan',
    parentId: null,
    locationId: '656a07b3f2d4a1001e2144bf',
    id: '656a07c3f2d4a1001e2144c5',
    sensor: (
      sensorType: SensorType.vibration,
      sensorStatus: SensorStatus.operating,
    ),
  );

  final rootComponent = ComponentEntity(
    name: 'Fan',
    parentId: null,
    locationId: null,
    id: '656a07c3f2d4a1001e2144c5',
    sensor: (
      sensorType: SensorType.energy,
      sensorStatus: SensorStatus.operating,
    ),
  );

  test('the created entities should be a ComponentEntity and an Item', () {
    expect(childComponent, isA<ComponentEntity>());
    expect(childComponent, isA<Item>());
    expect(locationChildComponent, isA<ComponentEntity>());
    expect(locationChildComponent, isA<Item>());
    expect(rootComponent, isA<ComponentEntity>());
    expect(rootComponent, isA<Item>());
  });

  test(
      'An asset\'s child component should have a parentId not null and locationId null',
      () {
    expect(childComponent.parentId, isNotNull);
    expect(childComponent.locationId, isNull);
    expect(childComponent.sensor, isA<Sensor>());
  });

  test(
      'A Location\'s child component should have a parentId null and locationId not null',
      () {
    expect(locationChildComponent.parentId, isNull);
    expect(locationChildComponent.locationId, isNotNull);
    expect(locationChildComponent.sensor, isA<Sensor>());
  });

  test('A root component should have both parentId null and locationId null',
      () {
    expect(rootComponent.parentId, isNull);
    expect(rootComponent.locationId, isNull);
    expect(rootComponent.sensor, isA<Sensor>());
  });

  test(
      'Creating an invalid component, with locationId and parentId not null, should throw an assertionError',
      () {
    expect(
        () => ComponentEntity(
                name: 'Fan',
                parentId: '656a07b3f2d4a1001e2144bf',
                locationId: '656a07b3f2d4a1001e2144bf',
                id: '656a07c3f2d4a1001e2144c5',
                sensor: (
                  sensorStatus: SensorStatus.alert,
                  sensorType: SensorType.vibration
                )),
        throwsAssertionError);
  });

  test(
      'Adding an item in a component should throw an exception since components can\'t have children',
      () {
    expect(rootComponent.itemChildren, isEmpty);
    expect(() => rootComponent.addChildren(childComponent), throwsException);
  });
}
