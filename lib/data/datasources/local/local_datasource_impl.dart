import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';

import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/extensions.dart';

import 'local_datasource.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<Either<Failure, List<String>>> fetchCompanies(
      {required String dirPath}) {
    final sampleDataDir = Directory(dirPath);
    final namesList = sampleDataDir.listSync().map((e) => e.name).toList();
    if (namesList.isEmpty) {
      throw const CompanyException(message: 'No Companies Found');
    }
    return Future.value(Right(namesList));
  }
}
