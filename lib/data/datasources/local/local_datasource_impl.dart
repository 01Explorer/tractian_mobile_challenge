import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';

import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
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

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getCompanyTreeComponents(
      {required String dirPath}) async {
    try {
      final listOfLocations =
          await _fileContentToMap(dirPath: '$dirPath/$locationsFileName');
      final listOfAssets =
          await _fileContentToMap(dirPath: '$dirPath/$assetFileName');
      for (final location in listOfLocations) {
        location['type'] = locationType;
      }

      for (final asset in listOfAssets) {
        if (asset.isComponent) {
          asset['type'] = componentType;
        } else {
          asset['type'] = assetType;
        }
      }

      return Right(listOfLocations..addAll(listOfAssets));
    } catch (e) {
      return Left(TreeFailure(message: e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> _fileContentToMap(
      {required String dirPath}) async {
    final locationsFile = File(dirPath);
    final locationsonFileContent = await locationsFile.readAsString();
    return decodeJsonList(locationsonFileContent);
  }

  List<Map<String, dynamic>> decodeJsonList(String jsonList) {
    final List<Map<String, dynamic>> decodedList =
        (jsonDecode(jsonList) as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
    return decodedList;
  }
}
