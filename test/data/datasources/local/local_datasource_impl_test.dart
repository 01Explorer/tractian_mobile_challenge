import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource_impl.dart';

void main() {
  late final LocalDataSource localDataSource;

  setUpAll(() {
    localDataSource = LocalDataSourceImpl();
  });

  const String emptyDir = './test/empty';

  test(
      'Calling fetchCompanies and passing a valid folder should return a list of Strings',
      () async {
    final result = await localDataSource.fetchCompanies(dirPath: sampleDataDir);
    result.fold(
        (l) => expect(l, isNull), (r) => expect(r, isA<List<String>>()));
  });

  test(
      'Calling fetchCompanies and passing a empty folder should throw a CompanyException',
      () async {
    expect(() async => await localDataSource.fetchCompanies(dirPath: emptyDir),
        throwsA(const CompanyException(message: 'No Companies Found')));
  });
}