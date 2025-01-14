import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_models_event.dart';
part 'vehicle_models_state.dart';

class VehicleModelsBloc extends Bloc<VehicleModelsEvent, VehicleModelsState> {
  final MasterDataRepository _masterDataRepository;

  VehicleModelsBloc(this._masterDataRepository)
      : super(VehicleModelsLoading()) {
    on<LoadVehicleModelsEvent>(_onLoadVehicleModelsEvent);
  }

  Future<void> _onLoadVehicleModelsEvent(
      LoadVehicleModelsEvent event, Emitter<VehicleModelsState> emit) async {
    try {
      emit(VehicleModelsLoading());
      final response = await _masterDataRepository.getVehicleModels();
      emit(VehicleModelsLoaded(models: response));
    } catch (e) {
      emit(VehicleModelsError(error: e.toString()));
    }
  }
}
