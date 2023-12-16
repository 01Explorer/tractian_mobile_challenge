import 'package:dartz/dartz.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';
import 'package:tractian_challenge/core/helpers/extensions.dart';
import 'package:tractian_challenge/data/datasources/local/local_datasource.dart';
import 'package:tractian_challenge/data/models/asset_model.dart';
import 'package:tractian_challenge/data/models/component_model.dart';
import 'package:tractian_challenge/data/models/location_model.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final LocalDataSource _localDataSource;

  CompanyRepositoryImpl(this._localDataSource);
  @override
  Future<Either<Failure, List<CompanyEntity>>> fetchCompanies() async {
    try {
      final result =
          await _localDataSource.fetchCompanies(dirPath: sampleDataDir);
      final companiesList = result.fold(
        (l) => null,
        (r) => r,
      );
      return Right(companiesList!
          .map((e) => CompanyEntity(name: e, rootComponents: []))
          .toList());
    } catch (e) {
      return Left(CompanyFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getCompanyTreeComponents(
      {required CompanyEntity companyEntity}) async {
    final companyPath = '$sampleDataDir/${companyEntity.name}';
    final result = await _localDataSource.getCompanyTreeComponents(
      dirPath: companyPath,
    );

    if (result.isLeft()) {
      return Left(
          TreeFailure(message: result.fold((l) => l.message, (r) => '')));
    }
    final itemsMap = <String, Item>{};
    final listOfJsons = result.fold((l) => <Map<String, dynamic>>[], (r) => r);
    final List<Item> rootsList = [];
    for (final entry in listOfJsons) {
      _addItemToMap(itemsMap, entry);

      if (entry.isRoot) {
        rootsList.add(itemsMap[entry['id']]!);
      }

      for (final item in itemsMap.values) {
        if (item.isRoot) {
          continue;
        }
        itemsMap[item.parent]!.addChildren(item);
      }
    }

    return Right(rootsList);
  }

  void _addItemToMap(Map<String, Item> itemsMap, Map<String, dynamic> entry) {
    itemsMap.putIfAbsent(
        entry['id'],
        () => switch (entry['type']) {
              locationType => LocationModel.fromJson(entry).toLocationEntity(),
              assetType => AssetModel.fromJson(entry).toAssetEntity(),
              _ => ComponentModel.fromJson(entry).toComponentEntity(),
            });
  }
}
