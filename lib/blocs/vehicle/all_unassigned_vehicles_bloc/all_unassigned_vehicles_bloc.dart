import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'all_unassigned_vehicles_event.dart';
part 'all_unassigned_vehicles_state.dart';

class AllUnassignedVehiclesBloc
    extends Bloc<AllUnassignedVehiclesEvent, AllUnassignedVehiclesState> {
  final VehicleRepository _repository;

  AllUnassignedVehiclesBloc(this._repository)
      : super(AllUnassignedVehiclesLoading()) {
    on<LoadAllUnassignedVehiclesEvent>(_onLoadAllUnassignedVehiclesEvent);
  }

  Future<void> _onLoadAllUnassignedVehiclesEvent(
      LoadAllUnassignedVehiclesEvent event,
      Emitter<AllUnassignedVehiclesState> emit) async {
    try {
      emit(AllUnassignedVehiclesLoading());
      final vehicles = await _repository.getAllUnassignedVehicles();
      emit(AllUnassignedVehiclesLoaded(vehicles: vehicles));
    } catch (e) {
      emit(AllUnassignedVehiclesError(error: e.toString()));
    }
  }
}
