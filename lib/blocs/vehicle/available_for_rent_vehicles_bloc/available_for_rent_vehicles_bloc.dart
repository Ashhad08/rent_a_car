import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'available_for_rent_vehicles_event.dart';
part 'available_for_rent_vehicles_state.dart';

class AvailableForRentVehiclesBloc
    extends Bloc<AvailableForRentVehiclesEvent, AvailableForRentVehiclesState> {
  final VehicleRepository _repository;

  AvailableForRentVehiclesBloc(this._repository)
      : super(AvailableForRentVehiclesLoading()) {
    on<LoadAvailableForRentVehiclesEvent>(_onLoadAvailableForRentVehiclesEvent);
  }

  Future<void> _onLoadAvailableForRentVehiclesEvent(
      LoadAvailableForRentVehiclesEvent event,
      Emitter<AvailableForRentVehiclesState> emit) async {
    try {
      emit(AvailableForRentVehiclesLoading());
      final vehicles = await _repository.getAvailableForRentVehicles();
      emit(AvailableForRentVehiclesLoaded(vehicles: vehicles));
    } catch (e) {
      emit(AvailableForRentVehiclesError(error: e.toString()));
    }
  }
}
