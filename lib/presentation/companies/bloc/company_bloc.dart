import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/fetch_companies_usecase.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final FetchCompaniesUsecase _fetchCompaniesUsecase;

  CompanyBloc(
    this._fetchCompaniesUsecase,
  ) : super(CompanyInitial()) {
    on<LoadCompaniesEvent>((event, emit) async {
      emit(CompanyLoading());
      final result = await _fetchCompaniesUsecase();
      result.fold(
        (failure) => emit(CompanyFailure(message: failure.message)),
        (companies) => emit(CompanyLoaded(companies: companies)),
      );
    });
  }
}
