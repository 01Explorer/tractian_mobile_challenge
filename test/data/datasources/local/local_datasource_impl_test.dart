import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource_impl.dart';

void main() {
  late final LocalDataSource localDataSource;

  setUpAll(() {
    localDataSource = LocalDataSourceImpl();
  });

  const String emptyDir = './test/empty';
  const int tobiasUnitLenght = 121;

  group('Fetch Companies', () {
    test(
        'Calling fetchCompanies and passing a valid folder should return a list of Strings',
        () async {
      final result =
          await localDataSource.fetchCompanies(dirPath: sampleDataDir);
      result.fold(
          (l) => expect(l, isNull), (r) => expect(r, isA<List<String>>()));
    });

    test(
        'Calling fetchCompanies and passing a empty folder should throw a CompanyException',
        () async {
      expect(
          () async => await localDataSource.fetchCompanies(dirPath: emptyDir),
          throwsA(const CompanyException(message: 'No Companies Found')));
    });
  });

  group('Get Company Tree Components', () {
    test(
        'Calling getCompanyTreeComponents and passing a valid folder should return a list of Map<String, dynamic>',
        () async {
      final result = await localDataSource.getCompanyTreeComponents(
          dirPath: '$sampleDataDir/Tobias Unit');

      result.fold(
        (l) => expect(l, isNull),
        (r) => expect(r, isA<List<Map<String, dynamic>>>()),
      );
    });
    test(
        'Calling getCompanyTreeComponents and passing a valid folder should return a list with the lenght of both location and assets jsons',
        () async {
      final result = await localDataSource.getCompanyTreeComponents(
          dirPath: '$sampleDataDir/Tobias Unit');

      result.fold(
        (l) => expect(l, isNull),
        (r) => expect(r.length, tobiasUnitLenght),
      );
    });

    test(
        'Calling getCompanyTreeComponents and passing a valid folder should return a list of map<String, dynamic> containing a type field != null',
        () async {
      final result = await localDataSource.getCompanyTreeComponents(
          dirPath: '$sampleDataDir/Tobias Unit');

      result.fold(
        (l) => expect(l, isNull),
        (r) {
          for (final element in r) {
            expect(element['type'], isNotNull);
          }
        },
      );
    });

    test(
        'Calling getCompanyTreeComponents and passing a invalid folder should return TreeFailure',
        () async {
      final result = await localDataSource.getCompanyTreeComponents(
          dirPath: '$sampleDataDir/NotExisting');

      result.fold(
        (l) => expect(l, isA<TreeFailure>()),
        (r) => expect(r, isNull),
      );
    });
  });
}
