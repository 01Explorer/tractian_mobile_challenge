import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/domain/usecases/get_company_tree_components_usecase.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_event.dart';
import 'package:tractian_challenge/presentation/tree_view/bloc/tree_view_state.dart';

class TreeViewBloc extends Bloc<TreeViewEvent, TreeViewState> {
  final GetCompanyTreeComponentsUseCase _getCompanyTreeComponentsUseCase;
  TreeViewBloc(this._getCompanyTreeComponentsUseCase)
      : super(TreeViewInitial()) {
    on<LoadTreeViewEvent>((event, emit) async {
      emit(TreeViewLoading());
      final result =
          await _getCompanyTreeComponentsUseCase(companyEntity: event.company);

      result.fold(
        (failure) => emit(TreeViewFailure(message: failure.message)),
        (rootAssets) => emit(TreeViewLoaded(
          rootAssets: rootAssets,
        )),
      );
    });
    on<FilterTreeViewEvent>((event, emit) async {
      emit(TreeViewLoading());
      final result =
          await _getCompanyTreeComponentsUseCase(companyEntity: event.company);

      result.fold(
        (failure) => emit(TreeViewFailure(message: failure.message)),
        (rootAssets) {
          if (event.filterCriticalSensor) {
            rootAssets = rootAssets.where((item) => item.isCritical).toList();
          }
          if (event.filterEnergySensor) {
            rootAssets =
                rootAssets.where((item) => item.isEletricSensor).toList();
          }
          if (event.filter.isNotEmpty) {
            rootAssets = rootAssets
                .where((item) => item.isBeingSearched(event.filter))
                .toList();
          }
          emit(TreeViewLoaded(
              rootAssets: rootAssets,
              filter: event.filter,
              isFilteredByCriticalSensor: event.filterCriticalSensor,
              isFilteredByEnergySensor: event.filterEnergySensor));
        },
      );
    });
  }
}
