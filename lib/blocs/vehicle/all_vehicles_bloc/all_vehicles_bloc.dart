import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'all_vehicles_event.dart';

part 'all_vehicles_state.dart';

class AllVehiclesBloc extends Bloc<AllVehiclesEvent, AllVehiclesState> {
  final VehicleRepository _repository;

  AllVehiclesBloc(this._repository) : super(AllVehiclesLoading()) {
    on<LoadAllVehiclesEvent>(_onLoadAllVehiclesEvent);
  }

  Future<void> _onLoadAllVehiclesEvent(
      LoadAllVehiclesEvent event, Emitter<AllVehiclesState> emit) async {
    try {
      emit(AllVehiclesLoading());
      final vehicles = await _repository.getAllVehicles();
      emit(AllVehiclesLoaded(vehicles: vehicles));
    } catch (e) {
      emit(AllVehiclesError(error: e.toString()));
    }
  }
}
