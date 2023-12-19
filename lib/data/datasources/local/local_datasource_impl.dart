import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/core/exceptions/custom_exceptions.dart';

import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/core/helpers/extensions.dart';

import 'local_datasource.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<Either<Failure, List<String>>> fetchCompanies(
      {required String dirPath}) async {
    final companies = await rootBundle.loadString(dirPath);
    final namesList = companies.split(';');
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
          await _fileContentToMap(filePath: '$dirPath/$locationsFileName');
      final listOfAssets =
          await _fileContentToMap(filePath: '$dirPath/$assetFileName');
      for (final location in listOfLocations) {
        location['type'] = locationType;
      }

      for (final asset in listOfAssets) {
        asset['type'] = asset.isComponent ? componentType : assetType;
      }

      return Right(listOfLocations..addAll(listOfAssets));
    } catch (e) {
      return Left(TreeFailure(message: e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> _fileContentToMap(
      {required String filePath}) async {
    final locationsonFileContent = await rootBundle.loadString(filePath);
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
