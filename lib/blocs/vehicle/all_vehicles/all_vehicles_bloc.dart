import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle.dart';
import '../../../domain/implementations/vehicle_api_repository.dart';

part 'all_vehicles_event.dart';
part 'all_vehicles_state.dart';

class AllVehiclesBloc extends Bloc<AllVehiclesEvent, AllVehiclesState> {
  final VehicleApiRepository _vehicleApiRepository;

  AllVehiclesBloc(this._vehicleApiRepository) : super(AllVehiclesLoading()) {
    on<LoadAllVehiclesEvent>(_onLoadAllVehiclesEvent);
  }

  Future<void> _onLoadAllVehiclesEvent(
      LoadAllVehiclesEvent event, Emitter<AllVehiclesState> emit) async {
    try {
      final response = await _vehicleApiRepository.getAllVehicles();
      emit(AllVehiclesLoaded(allVehicles: response));
    } catch (e) {
      emit(AllVehiclesError(error: e.toString()));
    }
  }
}
