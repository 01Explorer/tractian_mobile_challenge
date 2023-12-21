import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/core/exceptions/failure_exception.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';
import 'package:tractian_challenge/domain/entities/location_entity.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_bloc.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_event.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCompanyTreeComponentsUseCase getCompanyTreeComponentsUseCase;
  late TreeViewBloc treeViewBloc;

  setUp(() {
    getCompanyTreeComponentsUseCase = MockGetCompanyTreeComponentsUseCase();
    treeViewBloc = TreeViewBloc(getCompanyTreeComponentsUseCase);
  });

  final List<Item> rootTest = [
    LocationEntity(name: 'Location', parentId: null, id: '1'),
    LocationEntity(name: 'Location 2', parentId: null, id: '2'),
    LocationEntity(name: 'Location 3', parentId: null, id: '3'),
  ];

  final CompanyEntity companyTest =
      CompanyEntity(name: 'Company', rootComponents: rootTest);

  test('initial state should be TreeViewInitial', () {
    expect(treeViewBloc.state, TreeViewInitial());
  });

  group('LoadTreeViewEvent', () {
    blocTest<TreeViewBloc, TreeViewState>(
      'Should emit TreeViewLoading and then TreeViewLoaded when gets Data',
      build: () {
        when(getCompanyTreeComponentsUseCase(companyEntity: companyTest))
            .thenAnswer((_) async => Right(rootTest));
        return treeViewBloc;
      },
      act: (bloc) => bloc.add(LoadTreeViewEvent(company: companyTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TreeViewState>[
        TreeViewLoading(),
        TreeViewLoaded(rootAssets: rootTest),
      ],
    );

    blocTest<TreeViewBloc, TreeViewState>(
      'Should emit TreeViewLoading and then TreeViewFailure when fails to get data',
      build: () {
        when(getCompanyTreeComponentsUseCase(companyEntity: companyTest))
            .thenAnswer((_) async =>
                const Left(TreeFailure(message: 'Failed to retrieve data')));
        return treeViewBloc;
      },
      act: (bloc) => bloc.add(LoadTreeViewEvent(company: companyTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TreeViewState>[
        TreeViewLoading(),
        const TreeViewFailure(message: 'Failed to retrieve data'),
      ],
    );
  });

  group('FilterTreeViewEvent', () {
    blocTest<TreeViewBloc, TreeViewState>(
      'should emit TreeViewLoading and then TreeViewLoaded when gets Data successfuly but the filter parameters should be the same',
      build: () {
        when(getCompanyTreeComponentsUseCase(companyEntity: companyTest))
            .thenAnswer((_) async => Right(rootTest));
        return treeViewBloc;
      },
      act: (bloc) => bloc.add(
        FilterTreeViewEvent(
            company: companyTest,
            filter: '',
            filterCriticalSensor: false,
            filterEnergySensor: false),
      ),
      wait: const Duration(milliseconds: 500),
      expect: () => <TreeViewState>[
        TreeViewLoading(),
        TreeViewLoaded(
          rootAssets: rootTest,
          filter: '',
          isFilteredByCriticalSensor: false,
          isFilteredByEnergySensor: false,
        ),
      ],
    );

    blocTest<TreeViewBloc, TreeViewState>(
      'Should emit TreeViewLoading and then TreeViewFailure when fails to get data',
      build: () {
        when(getCompanyTreeComponentsUseCase(companyEntity: companyTest))
            .thenAnswer((_) async =>
                const Left(TreeFailure(message: 'Failed to retrieve data')));
        return treeViewBloc;
      },
      act: (bloc) => bloc.add(FilterTreeViewEvent(company: companyTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TreeViewState>[
        TreeViewLoading(),
        const TreeViewFailure(message: 'Failed to retrieve data'),
      ],
    );
  });
}
