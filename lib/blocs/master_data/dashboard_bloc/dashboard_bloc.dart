import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/dashboard_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MasterDataRepository _masterDataRepository;

  DashboardBloc(this._masterDataRepository) : super(DashboardLoading()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    try {
      emit(DashboardLoading());
      final response = await _masterDataRepository.getDashboardData();
      emit(DashboardLoaded(dashboardData: response));
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }

  Future<void> _onRefreshDashboardData(
      RefreshDashboardData event, Emitter<DashboardState> emit) async {
    try {
      final response = await _masterDataRepository.getDashboardData();
      emit(DashboardLoaded(dashboardData: response));
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }
}
